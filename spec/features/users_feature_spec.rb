feature 'User Management' do
  let!(:user_1)   { FactoryBot.create(:user, email: 'a@b.com') }
  let!(:user_2)   { FactoryBot.create(:user, email: 'a@c.com') }
  let!(:recipe_1) { FactoryBot.create(:recipe, user: user_1) }
  let!(:recipe_2) { FactoryBot.create(:recipe, user: user_2) }

  scenario 'Shows a welcome page when navigation to /' do
    visit '/'
    expect(page).to have_content('Welcome to Food Truck Hero!!')
  end

  context 'when not signed in' do
    before(:each) do
      visit '/'
    end

    scenario 'I can sign up as a new user' do
      sign_up
      expect(page).to have_content(I18n.t('devise.registrations.signed_up'))
    end

    scenario 'I can sign in as an existing user' do
      sign_up(email: 'test2@gmail.com', password: 'password123')
      click_sign_out_link_nav
      click_sign_in_link_nav
      fill_in :user_email, with: 'test2@gmail.com'
      fill_in :user_password, with: 'password123'
      click_button 'Log in'
      # binding.pry

      expect(page).to have_content(I18n.t('devise.sessions.signed_in'))
    end

    scenario 'I can see sign in/up links' do
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    scenario 'I cannot see sign out link' do
      expect(page).to have_no_link('Sign out')
    end

    scenario 'I cannot see any recipes' do
      expect(page).to have_no_link(recipe_1.title)
    end
  end

  context 'when signed in' do
    before(:each) do
      login_as(user_1, scope: :user)
      visit '/'
    end

    scenario 'I cannot see sign in/up links' do
      expect(page).to have_no_link('Sign in')
      expect(page).to have_no_link('Sign up')
    end

    scenario 'I can see sign out link' do
      expect(page).to have_link('Sign out')
    end

    scenario 'I can see recipes that belong to me' do
      expect(page).to have_content(recipe_1.title)
    end

    scenario 'I cannot see recipes that belong to another user' do
      expect(page).to have_no_content(recipe_2.title)
    end

    scenario 'I can edit my name' do
      click_link("#{user_1.first_name} #{user_1.last_name}")
      click_edit_user_link
      fill_in :user_first_name, with: "Different"
      fill_in :user_last_name, with: "Name"
      save_and_open_page
      fill_in :user_current_password, with: user_1.password
      click_button 'Update'
      expect(current_path).to eq root_path
      expect(page). to have_content("Different Name")
    end
  end
end
