class ManagersController < ApplicationController
  private
  def manager_params
    params.require(:nmanager).permit(:family_name, :family_name_kana, :given_name, :given_name_kana, :locale_id, :admin_id)
  end

  def admin_params
    params.require(:admin).permit(:id)
  end
end
