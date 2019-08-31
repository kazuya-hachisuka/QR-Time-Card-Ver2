class ManagersController < ApplicationController
  before_action :authenticate_admin!, only:[:index, :new,:create]
  before_action :authenticate_manager!, unless: -> { admin_signed_in?}

  def index
    @managers = Manager.includes(:locale).where(admin_id: current_admin.id)
  end

  def show
    @search = Work.ransack(params[:q])
    @manager = Manager.find(params[:id])
    @locale = Locale.find_by(id: @manager.locale_id)
    @works = @search.result.includes(:staff).where(locale_id: @locale.id)
    @admin = Admin.find_by(id: @manager.admin_id)
  end

  def new
    @admin = Admin.find(params[:admin_id])
    @locale = Locale.where(admin_id: params[:admin_id]).order(:id)
    @manager = Manager.new
  end

  def create
    manager = Manager.new(manager_params)
    if manager.save
      flash[:success] = 'マネージャーを追加しました。'
      redirect_to admin_path(current_admin)
    else
      flash[:danger] = '入力項目を確認してください。'
      redirect_to admin_managers_sing_up_path
    end
  end

  def destroy
    manager = Manager.find(params[:id])
    if manager.destroy
      flash[:success] = 'マネージャーを削除しました。'
      redirect_to admin_managers_path
    else
      render 'index'
    end

  end

  private
  def manager_params
    params.require(:manager).permit(:id, :family_name, :family_name_kana, :given_name, :given_name_kana, :locale_id, :admin_id, :email, :password)
  end

  def admin_params
    params.require(:admin).permit(:id, :company_name)
  end

  def locale_params
    params.require(:locale).permit(:locale_name, :admin_id, :control_number)
  end
end
