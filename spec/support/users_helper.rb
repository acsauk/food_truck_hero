def sign_up(email: 'test@gmail.com', password: 'password123')
  visit '/'
  click_link 'Sign up'
  fill_in :user_email, with: email
  fill_in :user_password, with: password
  fill_in :user_password_confirmation, with: password
  click_button 'Sign up'
end

def log_in(email: 'test@gmail.com', password: 'password123')
  visit '/'
  click_link 'Sign in'
  fill_in :user_email, with: email
  fill_in :user_password, with: password
  click_button 'Log in'
end
