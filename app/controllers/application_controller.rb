class ApplicationController < ActionController::Base
  include Pagy::Backend
  include ApplicationHelper

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    update_attrs = %i[first_name
                      last_name
                      email
                      password
                      password_confirmation
                      current_password]
    devise_parameter_sanitizer.permit :sign_up, keys: %i[first_name
                                                         last_name
                                                         update_attrs]
    devise_parameter_sanitizer.permit :account_update, keys: update_attrs
  end
end
