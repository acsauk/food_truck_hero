def sign_up(email:      'test@gmail.com',
            password:   'password123',
            first_name: 'Joe',
            last_name:  'Blogss')
  visit '/'
  click_sign_up_link_nav
  fill_in :user_email, with: email
  fill_in :user_first_name, with: first_name
  fill_in :user_last_name, with: last_name
  fill_in :user_password, with: password
  fill_in :user_password_confirmation, with: password
  click_button 'Sign up'
end

def sign_in(email: 'test@gmail.com', password: 'password123')
  visit '/'
  click_sign_in_link_nav
  fill_in :user_email, with: email
  fill_in :user_password, with: password
  click_button 'Log in'
end

def login_user
  Warden.test_mode!
  user = FactoryBot.create(:user)
  login_as user, :scope => :user
  user.confirmed_at = Time.now
  user.save
  user
end

def click_sign_up_link_nav
  find("#nav_bar > a[href='#{new_user_registration_path}']").click
end

def click_sign_in_link_nav
  find("#nav_bar > a[href='#{new_user_session_path}']").click
end

def click_sign_out_link_nav
  find("#nav_bar > a[href='#{destroy_user_session_path}']").click
end

def click_user_account_link_nav(user)
  find("#nav_bar > a[href='#{user_path(user.id)}']").click
end

def click_edit_user_link
  find("a[href='#{edit_user_registration_path}']").click
end
