module ApplicationHelper
  # 退勤時間 - 出勤時間 - 休憩時間合計= "%dh%02dm"に変換
  def workingHours(work)
    work_breaks = WorkBreak.where(work_id: work.id)
    total_sec = 0
    work_breaks.each do |work_break|
      total_sec += work_break.out - work_break.in
    end
    sec = work.out - work.in - total_sec
    work_min = sec.to_i / 60
    hh, mm = work_min.divmod(60)
    "%dh%02dm" % [hh,mm]
  end

  # work_id紐ついたwork_breakの全部をeachで　out - in =　"%dh%02dm"に変換
  def totalWorkBreak(work)
    work_breaks = WorkBreak.where(work_id: work.id)
    total_sec = 0
    work_breaks.each do |work_break|
      total_sec += work_break.out - work_break.in
    end
    work_break_min = total_sec.to_i / 60
    hh, mm = work_break_min.divmod(60)
    "%dh%02dm" % [hh,mm]
  end

  def timeFormat(material)
    material.strftime("%Y年%m月%d日 %-H:%M")
  end

end
