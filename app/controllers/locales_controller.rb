class LocalesController < ApplicationController
  before_action :current_locale
  before_action :require_sign_in!
  helper_method :sign_in?

  skip_before_action :require_sign_in!, only: [:new, :create]

  def index
    @locale = Locale.all
  end

  def show
    
  end

  def new
    @locale = Locale.new
  end

  def create
    @locale = Locale.new(locale_params)
    # binding.pry
    if @locale.save
      redirect_to login_path
    else
      render 'new'
    end

  end

  private

  def locale_params
    params.require(:locale).permit(:locale_name, :admin_id, :control_number, :password, :password_confirmation)
  end

  def admin_params
    params.require(:admin).permit(:id, :company_name)
  end
end
