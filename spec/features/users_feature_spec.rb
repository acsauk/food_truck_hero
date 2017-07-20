feature 'User Management' do
  scenario 'Shows a welcome page when navigation to /' do
    visit '/'

    expect(page).to have_content('Welcome to Food Truck Hero!!')
  end

  scenario 'I can sign up as a new user' do
    visit '/'
    click_button 'Sign up'
    fill_in :email, with: 'test_email@gmail.com'
    fill_in :password, with: 'Password123'
    fill_in :password_confirmation, with: 'Password123'
    click_button 'Sign up'

    expect(page).to have_content('Successfully signed up as test_email@gmail.com')
  end
end
