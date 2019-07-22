class WorksController < ApplicationController
  require "date"

  def new
    @locale = Locale.find(current_locale.id)
    @staff = Staff.find(params[:staff_id])
    @working = @staff.works.where(out: nil)
  end

  def punch_in
    @work = Work.new
    @work.in = DateTime.now
    staff = Staff.find(params[:staff_id])
    staff.status = 1
    staff.save
    @work.staff_id = staff.id
    @work.locale_id = current_locale.id
    @work.save
    redirect_to locale_path(current_locale)
  end

  def punch_out
    @staff = Staff.find(params[:staff_id])
    @staff.status = 0
    @staff.save
    work = Work.find(params[:work_id])
    work.update(out: DateTime.now)
    redirect_to locale_path(current_locale)
  end

  def break_in
    staff = Staff.find(Work.find(params[:work_id]).staff_id)
    staff.status = 2
    staff.save
    @work_break = WorkBreak.new
    @work_break.in = DateTime.now
    @work_break.work_id = params[:work_id]
    @work_break.save
    redirect_to locale_path(current_locale)
  end

  def break_out
    staff = Staff.find(Work.find(params[:work_id]).staff_id)
    staff.status = 1
    staff.save
    @work_break = WorkBreak.last
    @work_break.update(out: DateTime.now)
    redirect_to locale_path(current_locale)
  end

  private

  def work_params
    params.require(:work).permit(:in, :out, :staff_id, :locale_id)
  end

  def work_break_params
    params.require(:work_break).permit(:in, :out, :work_id)
  end

  def staff_params
    params.require(:staff).permit(:family_name, :family_name_kana, :given_name, :given_name_kana, :admin_id, :locale_id, :qrcode, :status)
  end


  def locale_params
    params.require(:locale).permit(:locale_name, :admin_id, :control_number, :password, :password_confirmation)
  end

end