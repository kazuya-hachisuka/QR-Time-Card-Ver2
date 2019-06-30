class StaffsController < ApplicationController
  def new
    @staff = Staff.new
    @locale = Locale.find_by(params[:id])
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
  def staff_params
    params.require(:staff).permit(:family_name, :family_name_kana, :given_name, :given_name_kana, :locale_id, :qrcode)
  end

  def locale_params
    params.require(:locale).permit(:id, :locale_name)
  end

end
