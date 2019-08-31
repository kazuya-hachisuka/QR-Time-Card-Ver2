class SessionsController < ApplicationController
  # before_action :current_locale
  skip_before_action :require_sign_in!, only: [:create], raise: false
  before_action :set_locale, only:[:create]
  helper_method :sign_in?

  def new
  end

  #ログイン画面で入力された値を検証
  def create
  #authenticateメソッドで入力されたpasswordを暗号化し、DBのpassword_digestと一致するかを検証
    if @locale.authenticate(session_params[:password])
      #検証が通ればsing_inメソッドを呼び出し、remember_tokenを作成し、localeモデルのcookieにセットし、ログイン後の画面に遷移
      locale_sign_in(@locale)
      redirect_to locale_path(@locale[:id])
    else
      flash.now[:danger] = 'パスワードが間違っています。'
      render 'new'
    end
  end

  #ログアウト処理
  def destroy
    locale_sign_out
    redirect_to root_path
  end

  private

  def set_locale
    @locale = Locale.find_by!(control_number: session_params[:control_number])
  rescue
    flash.now[:danger] = '勤務地番号を入力してください。'
    render action: 'new'
  end

  #許可するパラメータ
  def session_params
    params.require(:session).permit(:control_number,:password)
  end
end
