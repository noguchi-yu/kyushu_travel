class ApplicationController < ActionController::Base
  add_flash_types :success, :danger
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [ :email, :password, :password_confirmation, :name, :avatar ]
    # /users/sign_up
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :avatar])
    # /users/account_update
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :avatar])
    # /users/sign_in
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name, :avatar])
  end
end
