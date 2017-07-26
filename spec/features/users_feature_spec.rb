feature 'User Management' do
  scenario 'Shows a welcome page when navigation to /' do
    visit '/'
    expect(page).to have_content('Welcome to Food Truck Hero!!')
  end

  context 'when not signed in' do
    scenario 'I can sign up as a new user' do
      visit '/'
      click_link 'Sign up'
      fill_in :user_email, with: 'test_email@gmail.com'
      fill_in :user_password, with: 'Password123'
      fill_in :user_password_confirmation, with: 'Password123'
      click_button 'Sign up'

      expect(page).to have_content(I18n.t('devise.registrations.signed_up'))
    end

    scenario 'I can see sign in/up links' do
      visit '/'
      expect(page).to have_content('Sign in')
      expect(page).to have_content('Sign up')
    end
  end
end
