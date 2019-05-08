class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_admin!
  # before_action :current_locale
  # before_action :require_sign_in!
  # helper_method :sign_in?


  # def current_locale
  #   remember_token = Locale.encrypt(cookies[:locale_remember_token])
  #   @current_locale ||= Locale.find_by(remember_token: remember_token)
  # end

  # def sign_in(locale)
  #   remenber_token = Locale.new_remember_token
  #   cookies.permanent[:locale_remember] = new_remember_token
  #   locale.update!(remember_token: Locale.encrypt(remenber_token))
  #   @current_locale = locale
  # end

  # def sign_out
  #   @current_locale = nil
  #   cookies.delete(:locale_remember_token)
  # end

  # def signd_in?
  #   @current_locale.present?
  # end

  private

  def after_sign_in_path_for(resource)
    if admin_signed_in?
      admin_path(current_admin[:id])
    else
      new_admin_session_path
    end
  end

  def after_sing_out_path_for(resource)
    new_admin_session_path
  end

  # def require_sign_in!
  #   redirect_to login_path unless signed_in?
  # end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:[:email, :company_name, :company_name_kana])
    devise_parameter_sanitizer.permit(:sign_in, keys:[:email])
  end

  def correct_admin?
		admin = Admin.where(id: params[:id]).exists? && Admin.find(params[:id])
		if admin
			unless admin == current_admin
				flash[:error] = "他のユーザー情報は変更できません！"
				redirect_back(fallback_location: root_path)
			end
		else
			flash[:error] = "ユーザーが存在しません！"
			redirect_back(fallback_location: root_path)
		end
  end

end
