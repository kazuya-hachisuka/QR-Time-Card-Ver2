class StaffsController < ApplicationController
  def index
    @staffs = Staff.includes(:locale).where(admin_id: current_admin)
  end

  def new
    @staff = Staff.new
    @locale = Locale.find_by(params[:id])
    @admin_id = Locale.where(id: params[:locale_id]).pluck(:admin_id) #もう少し簡単に書けそう
  end

  def create
    @staff = Staff.new(staff_params)
    @staff.locale_id = params[:locale_id]
    if @staff.save
      redirect_to locale_path(params[:locale_id])
    else
      redirect_to new_locale_staff_path
    end
  end

  def edit
    @staff = Staff.find(params[:id])
    @locale = Locale.where(admin_id: current_admin)
    @admin = Admin.find_by(id: current_admin)
    require 'rqrcode'
    require 'rqrcode_png'
    content = "https://www.google.co.jp/"
    size    = 5
    level   = :h            # l, m, q, h
    @qr = RQRCode::QRCode.new(content, size: size, level: level).as_svg(module_size: 6).html_safe
  end

  def update
    staff = Staff.find(params[:id])
    if staff.update(staff_params)
      redirect_to admin_path(current_admin)
    else
      redirect_to edit_locale_staff_path
    end
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
