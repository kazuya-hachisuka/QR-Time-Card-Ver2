class LocalesController < ApplicationController
  before_action :current_locale
  # before_action :require_sign_in!
  helper_method :sign_in?
  skip_before_action :require_sign_in!, only: [:new, :create], raise: false

  def index
    @locale = Locale.all
  end

  def show
    @locale = Locale.find(params[:id])
    @staff = Staff.where(locale_id: @locale)
  end

  def new
    @locale = Locale.new
  end

  def create
    @locale = Locale.new(locale_params)
    #errorがなければsaveして、passwordはpassword_digestに暗号化され保存される
    if @locale.save
      redirect_to login_path(@locale)
    else
      render 'new'
    end

  end

  private

  def locale_params
    params.require(:locale).permit(:locale_name, :admin_id, :control_number, :password, :password_confirmation)
  end

  # def admin_params
  #   params.require(:admin).permit(:id, :company_name)
  # end
end
