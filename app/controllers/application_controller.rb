class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if:  :devise_controller?
  before_action :set_locale

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :username, 
      :email, 
      :password, 
      :password_confirmation, 
      :remember_me, 
      :fname, 
      :lname, 
      :booking_id
    ] )
    devise_parameter_sanitizer.permit(:sign_in, keys: [
      :login,
      :email,
      :password,
      :remember_me
    ] )
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :username, 
      :email, 
      :password, 
      :password_confirmation, 
      :current_password
    ] )
  end

  def set_locale
    cookies.permanent[:locale] = params[:locale] if params[:lc].present?
    # set locale to en always
    domain_locale = request.domain == :en
    I18n.locale = cookies.permanent[:locale] || params[:locale] || domain_locale || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def self.default_url_options(options = {})
    options.merge(locale: I18n.locale)
  end
end
