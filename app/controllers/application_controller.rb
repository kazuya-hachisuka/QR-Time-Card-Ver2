class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?


  def sign_in(locale)
    remenber_token = Locale.new_remember_token
    cookies.permanent[:locale_remember] = new_remember_token
    locale.update!(remember_token: Locale.encrypt(remenber_token))
    @current_locale = locale
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:[:company_name, :company_name_kana])
    devise_parameter_sanitizer.permit(:sign_in, keys:[:email])
  end
end
