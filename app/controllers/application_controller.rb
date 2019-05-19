class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :current_locale
  # before_action :require_sign_in!
  # helper_method :sign_in?

  def after_sign_in_path_for(resource)
    if admin_signed_in?
      admin_path(id: current_admin[:id])
    elsif manager_signed_in?
      manager_path(id: current_manager[:id])
    else
			root_path
    end
  end

  def after_sing_out_path_for(resource)
    root_path
  end

  def current_locale
    remember_token = Locale.encrypt(cookies[:locale_remember_token])
    @current_locale ||= Locale.find_by(remember_token: remember_token)
  end

#remenber_tokenを作成し、localeモデルとcookieにセットし、login後の画面に遷移
  # def sign_in(locale)
  #   remember_token = Locale.new_remember_token
  #   cookies.permanent[:locale_remember_token] = remember_token
  #   locale.update!(remember_token: Locale.encrypt(remember_token))
  #   @current_locale = locale
  # end

  def sign_out
    @current_locale = nil
    cookies.delete(:locale_remember_token)
  end

  def signd_in?
    @current_locale.present?
  end

  private

  def authenticate_admin
    if admin_signed_in?
    else
      redirect_to root_path
    end
  end

  def authenticate_manager
    if manager_signed_in?
    else
      redirect_to root_path
    end
  end

  def require_sign_in!
    redirect_to login_path unless signed_in?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:[:email, :company_name, :company_name_kana])
    devise_parameter_sanitizer.permit(:sign_in, keys:[:email])
  end

  def correct_admin?
		admin = Admin.where(id: params[:id]).exists? && Admin.find(params[:id])
		if admin
			unless admin == current_admin
				flash[:error] = "他の管理者情報は変更できません！"
				redirect_back(fallback_location: admin_path(current_admin))
			end
		else
			flash[:error] = "管理者が存在しません！"
			redirect_back(fallback_location: admin_path(current_admin))
		end
  end

end
