class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # /users/sign_up
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :avatar])
    # /users/account_update
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :avatar])
  end
end
