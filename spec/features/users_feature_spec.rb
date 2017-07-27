feature 'User Management' do
  scenario 'Shows a welcome page when navigation to /' do
    visit '/'
    expect(page).to have_content('Welcome to Food Truck Hero!!')
  end

  context 'when not signed in' do
    scenario 'I can sign up as a new user' do
      sign_up

      expect(page).to have_content(I18n.t('devise.registrations.signed_up'))
    end

    scenario 'I can sign in as an existing user' do
      sign_up
      click_link 'Sign out'
      click_link 'Sign in'
      fill_in :user_email, with: 'test_email@gmail.com'
      fill_in :user_password, with: 'Password123'
      click_button 'Log in'

      expect(page).to have_content(I18n.t('devise.sessions.signed_in'))
    end

    scenario 'I can see sign in/up links' do
      visit '/'
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    scenario 'I cannot see sign out link' do
      visit '/'
      expect(page).to have_no_link('Sign out')
    end
  end
end
