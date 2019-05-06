class LocalesController < ApplicationController

  def index
    @locale = Locale.all
  end

  def new
    @locale = Locale.new
  end

  def create
    @locale = Locale.new(locale_params)
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
