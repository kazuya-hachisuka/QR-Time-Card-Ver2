class ManagersController < ApplicationController
  before_action :authenticate_manager!

  def show
    @manager = Manager.find(params[:id])
  end

  def new
    @admin = Admin.find(params[:admin_id])
    @locale = Locale.where(admin_id: params[:admin_id])
    @manager = Manager.new
  # binding.pry
  end

  def create
    manager = Manager.new(manager_params)
    if manager.save
      redirect_to manager_session_path
    else
      redirect_to root_path
    end
  end

  private
  def manager_params
    params.require(:manager).permit(:id, :family_name, :family_name_kana, :given_name, :given_name_kana, :locale_id, :admin_id, :email, :password)
  end

  def admin_params
    params.require(:admin).permit(:id)
  end

  def locale_params
    params.require(:locale).permit(:locale_name, :admin_id, :control_number)
  end
end
