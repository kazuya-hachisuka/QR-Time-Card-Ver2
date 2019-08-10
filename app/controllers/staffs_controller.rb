class StaffsController < ApplicationController
  def index
    @staffs = Staff.includes(:locale).where(admin_id: current_admin)
  end

  def show
    @staff = Staff.find(params[:id])
    @locale = Locale.find_by(id: @staff.locale_id)
  end

  def new
    @staff = Staff.new
    @locale = Locale.where(admin_id: params[:admin_id])
    @admin = Admin.find(params[:admin_id])
  end

  def create
    @staff = Staff.new(staff_params)
    if @staff.save
      @staff.qrcode = "http://localhost:3000/staffs/#{@staff.id}/punch_new"
      @staff.save
      flash[:staff_create_result] = "スタッフを追加しました。"
      redirect_to admin_staff_path(@staff.id)
    else
      flash[:staff_create_result] = "入力項目を確認してくだい。"
      redirect_to new_admin_staff_path(current_admin)
    end
  end

  def edit
    @staff = Staff.find(params[:id])
    @locale = Locale.where(admin_id: current_admin)
    @admin = Admin.find_by(id: current_admin)
    require 'rqrcode'
    require 'rqrcode_png'
    content = "#{@staff.qrcode}"
    size    = 5
    level   = :h            # l, m, q, h
    @qr = RQRCode::QRCode.new(content, size: size, level: level).as_svg(module_size: 6).html_safe
  end

  def update
    staff = Staff.find(params[:id])
    if staff.update(staff_params)
      redirect_to admin_staffs_path(current_admin)
    else
      redirect_to edit_locale_staff_path
    end
  end

  def destroy
    @staff = Staff.find(params[:id])
    #@staff.destroy
    redirect_to admin_staffs_path(current_admin)
  end

  private
  def admin_params
    params.require(:admin).permit(:company_name, :company_name_kana)
  end

  def staff_params
    params.require(:staff).permit(:family_name, :family_name_kana, :given_name, :given_name_kana, :admin_id, :locale_id, :qrcode)
  end

  def locale_params
    params.require(:locale).permit(:id, :locale_name, :admin_id)
  end

end
