class WorksController < ApplicationController
  require "date"
  def index
    @staff = Staff.find(params[:staff_id])
    @search = Work.ransack(params[:q])
    @works = @search.result.includes(:locale).where(staff_id: @staff).order(in: :asc)
  end

  def show
    @work = Work.find(params[:id])
    @staff = Staff.find(@work.staff_id)
    @locale = Locale.find(@work.locale_id)
    @work_breaks = WorkBreak.where(work_id: params[:id])
  end

  def new
    @locales = Locale.where(admin_id: company_id)
    @work = Work.new
    @staff = Staff.find(params[:staff_id])
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:work_create_result] = "勤怠を追加しました。"
    else
      flash[:work_create_result] = "追加出来ませでした。"
    end
    url = request.url
    redirect_back(fallback_location: url)
  end

  def punch_new
    @locale = Locale.find(current_locale.id)
    @staff = Staff.find(params[:staff_id])
    @working = @staff.works.where(out: nil)
    unless @staff.admin_id == @locale.admin_id
      redirect_to locale_path(current_locale)
      flash[:other_admin] = "こちらの会社には所属してません"
    end
    @id = current_locale.id
    #@idForJs = @id.to_json
  end

  def update
    @work = Work.find(params[:id])
    if params[:work_breaks].present?
      ActiveRecord::Base.transaction do
        @work.update_attributes!(work_params)
        WorkBreak.multi_update(work_breaks_params)
      end
    else
      @work.update(work_params)
    end
    if admin_signed_in?
      redirect_to locale_path(@work.locale_id)
    elsif manager_signed_in?
      redirect_to manager_path(current_manager)
    end
  end

  def destroy
    work = Work.find(params[:id])
    if work.destroy
      flash[:work_delete_result] = "削除しました"
    else
      flash[:work_delete_result] = "削除出来ませんでした"
    end
    url = request.url
    redirect_back(fallback_location: url)
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
    params.require(:work_break).permit(:id, :in, :out, :work_id)
  end

  #work_breaks_paramsがunpermitedだったので、permit!で強制的に許可
  def work_breaks_params
    params.require(:work_breaks).permit!
  end

  def staff_params
    params.require(:staff).permit(:family_name, :family_name_kana, :given_name, :given_name_kana, :admin_id, :locale_id, :qrcode, :status)
  end


  def locale_params
    params.require(:locale).permit(:locale_name, :admin_id, :control_number, :password, :password_confirmation)
  end

end
