def sign_up(email: 'test@gmail.com', password: 'password123')
  visit '/'
  click_link 'Sign up'
  fill_in :user_email, with: 'test_email@gmail.com'
  fill_in :user_password, with: 'Password123'
  fill_in :user_password_confirmation, with: 'Password123'
  click_button 'Sign up'
end
