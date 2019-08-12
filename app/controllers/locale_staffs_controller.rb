class LocaleStaffsController < ApplicationController

  def index
    @locale = Locale.preload(:staffs).find(params[:locale_id])
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
