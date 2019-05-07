class AdminsController < ApplicationController

  def show
    @admin = Admin.find(current_admin[:id])
  end

  private

  def admin_params
    params.require(:admin).permit[:id, :company_name, :company_name_kana]
  end
end
