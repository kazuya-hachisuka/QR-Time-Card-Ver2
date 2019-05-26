class AdminsController < ApplicationController
  before_action :authenticate_admin!
  before_action :correct_admin?

  def show
    @admin = Admin.find(params[:id])
    @locale = Locale.where(admin_id: @admin)
  end

  private

  def admin_params
    params.require(:admin).permit[:company_name, :company_name_kana]
  end
end
