feature 'User Management' do
  scenario 'Shows a welcome page when navigation to /' do
    puts 'Shows a welcome page when navigation to /'
    visit '/'
    expect(page).to have_content('Welcome to Food Truck Hero!!')
  end

  context 'when not signed in' do
    before(:each) do
      visit '/'
    end

    scenario 'I can sign up as a new user' do
      puts 'I can sign up as a new user'
      sign_up
      expect(page).to have_content(I18n.t('devise.registrations.signed_up'))
    end

    scenario 'I can sign in as an existing user' do
      puts 'I can sign in as an existing user'
      sign_up(email: 'test2@gmail.com')
      click_link 'Sign out'
      click_link 'Sign in'
      fill_in :user_email, with: 'test2@gmail.com'
      fill_in :user_password, with: 'password123'
      click_button 'Log in'

      expect(page).to have_content(I18n.t('devise.sessions.signed_in'))
    end

    scenario 'I can see sign in/up links' do
      puts 'I can see sign in/up links'
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    scenario 'I cannot see sign out link' do
      puts 'I cannot see sign out link'
      expect(page).to have_no_link('Sign out')
    end
  end

  context 'when signed in' do
    before(:each) do
      visit '/'
      sign_up
      click_link 'Sign in'
      fill_in :user_email, with: 'test@gmail.com'
      fill_in :user_password, with: 'password123'
      click_button 'Log in'
    end

    scenario 'I cannot see sign in/up links' do
      puts 'I cannot see sign in/up links'
      expect(page).to have_no_link('Sign in')
      expect(page).to have_no_link('Sign up')
    end

    scenario 'I can see sign out link' do
      puts 'I can see sign out link'
      expect(page).to have_link('Sign out')
    end
  end
end
