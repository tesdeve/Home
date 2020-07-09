class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation]) #:first_name, :last_name, :username,  , :remember_me
    devise_parameter_sanitizer.permit(:sign_in, keys: [ :email, :password])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :username, :email, :current_password, :password, :password_confirmation, :remember_me])
  end

end
