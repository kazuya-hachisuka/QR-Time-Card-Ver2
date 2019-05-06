class SessionsController < ApplicationController
  skip_before_action :require_sign_in!, only: [:new, :create]
  before_action :set_user, only:[:create]

  def new
  end

  def create
    if @locale.authenticate(session_params[:password])
      sign_in(@locale)
      redirect_to root_path
    else
      flash.now[:danger] = t('.flash.invaled_password')
      render 'sessions#new'
    end
  end

  def destroy
    sign_out
    redirect_to login_path
  end

  private

  def set_locale
    @locale = Locale.find_by!(control_number: session_params[:control_number])
  rescue
    flash.now[:danger] = t('.flash.invalid_control_number')
    render action: 'new'
  end

  #許可するパラメータ
  def session_params
    params.require(:session).permit(:control_number,:password)
  end
end
