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

  #1つのwork_breakの合計時間算出用
  def totalWorkBreak_WB(workBreak)
    total_sec = 0
    total_sec = workBreak.out - workBreak.in
    work_break_min = total_sec.to_i / 60
    hh, mm = work_break_min.divmod(60)
    "%dh%02dm" % [hh,mm]
  end
  #スタッフの勤怠合計算出(勤怠合計-休憩合計)
  def totalWorkTime(works)
    total_work_time_sec = 0
    total_work_break_time_sec = 0
    works.each do |work|
      total_work_time_sec += work.out - work.in
      work_breaks = WorkBreak.where(work_id: work.id)
      work_breaks.each do |work_break|
        total_work_break_time_sec += work_break.out - work_break.in
      end
    end
    total_work_time = (total_work_time_sec - total_work_break_time_sec).to_i / 60
    hh, mm = total_work_time.divmod(60)
    "%dh%02dm" % [hh,mm]
  end

  #gem 'i18n_generators'を導入したので使用しない
  # def timeFormat(material)
  #   material.strftime("%Y年%m月%d日 %-H:%M")
  # end

end
