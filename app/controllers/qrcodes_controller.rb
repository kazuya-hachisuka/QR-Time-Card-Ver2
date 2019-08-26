class QrcodesController < ApplicationController
  before_action :admin_signed_in? || :manager_signed_in?
  def show
    @staff = Staff.find(params[:staff_id])
    @admin = Admin.find(params[:admin_id])
    require 'rqrcode'
    require 'rqrcode_png'
    content = "#{@staff.qrcode}"
    size    = 5
    level   = :h            # l, m, q, h
    @qr = RQRCode::QRCode.new(content, size: size, level: level).as_svg(module_size: 6).html_safe
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
