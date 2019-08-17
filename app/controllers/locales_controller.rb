class LocalesController < ApplicationController
  before_action :current_locale
  # before_action :require_sign_in!
  helper_method :sign_in?
  skip_before_action :require_sign_in!, only: [:new, :create], raise: false

  def show
    @locale = Locale.find(params[:id])
    #@works = Work.includes(:staff).where(locale_id: @locale).order(in: :asc)
    @search = Work.ransack(params[:q])
    @works = Work.ransack(params[:q]).result .includes(:staff).where(locale_id: @locale).order(in: :asc)
  end

  def new
    @locale = Locale.new
  end

  def create
    @locale = Locale.new(locale_params)
    #errorがなければsaveして、passwordはpassword_digestに暗号化され保存される
    if @locale.save
      redirect_to admin_path(current_admin)
    else
      render 'new'
    end

  end

  private

  def locale_params
    params.require(:locale).permit(:locale_name, :admin_id, :control_number, :password, :password_confirmation)
  end

  def work_params
    params.require(:work).permit(:in, :out, :locale_id, :staff_id)
  end

  # def admin_params
  #   params.require(:admin).permit(:id, :company_name)
  # end
end
