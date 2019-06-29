class StaffsController < ApplicationController
  def new
    @staff = Staff.new
    @locale = Locale.find(params[:locale_id])
  end

  def create
    @staff = Staff.new(staff_params[:locale_id])
    if @staff.save
      redirect_to root_path
    else
      redirect_to new_locale_staff_path
    end
  end

  private
  def staff_params
    params.require(:staff).permit(:family_name, :family_name_kana, :given_name, :given_name_kana, :locale_id, :qrcode)
  end

  def locale_params
    params.require(:locale).permit(:id, :locale_name)
  end
end
