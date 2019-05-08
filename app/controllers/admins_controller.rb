class AdminsController < ApplicationController
  before_action :correct_admin?

  def show
    @admin = Admin.find(params[:id])
  end

  private

  def admin_params
    params.require(:admin).permit[:id, :company_name, :company_name_kana]
  end
end
