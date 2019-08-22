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

  #勤怠を計算した結果を時間に変換
  def convertToTime(sec)
    min = sec.to_i / 60
    hh, mm = min.divmod(60)
    "%dh%02dm" % [hh,mm]
  end

  def midnight(work_in, work_out)

    work_5 = work_in.to_date
    work_5 = work_5.to_s + " 5:00:00"
    work_5 = work_5.in_time_zone

    work_0 = work_in.to_date
    work_0 = work_0.to_s + " 00:00:00"
    work_0 = work_0.in_time_zone

    work_24 = work_in.to_date
    work_24 = work_24.to_s + " 00:00:00"
    work_24 = work_24.in_time_zone.tomorrow

    work_29 = work_in.to_date
    work_29 = work_29.to_s + " 5:00:00"
    work_29 = work_29.in_time_zone.tomorrow

    work_22 = work_in.to_date
    work_22 = work_22.to_s + " 22:00:00"
    work_22 = work_22.in_time_zone

    work_46 = work_out.to_date
    work_46 = work_46.to_s + " 22:00:00"
    work_46 = work_46.in_time_zone

    work_48 = work_out.to_date
    work_48 = work_48.to_s + " 00:00:00"
    work_48 = work_48.in_time_zone.tomorrow

    midnight_a = work_0..work_5
    midnight_b = work_22..work_24
    midnight_c = work_24..work_29
    midnight_d = work_46..work_48

    midnight_work = 0

    # 出勤と退勤が同じ日付の場合
    if work_in.strftime('%Y/%m/%d') == work_out.strftime('%Y/%m/%d')
      # 出勤が00時−05時に含まれるか
      if midnight_a.cover?(work_in)
        # 退勤が00時ー05時に含まれるか
        if midnight_a.cover?(work_out)
          midnight_work = work_out.in_time_zone - work_in.in_time_zone
          return midnight_work
        # 退勤が22時ー24時に含まれるか
        elsif midnight_b.cover?(work_out)
          midnight_work = work_5.in_time_zone - work_in.in_time_zone
          midnight_work += work_out.in_time_zone - work_22.in_time_zone
          return midnight_work
        # それ以外(退勤が05時ー22時)
        else
          midnight_work = work_5.in_time_zone - work_in.in_time_zone
          return midnight_work
        end
      # 出勤が22時ー24時に含まれるか
      elsif midnight_b.cover?(work_in)
        midnight_work = work_out.in_time_zone - work_in.in_time_zone
        return midnight_work
      # それ以外(出勤が5時ー22時)
      else
        # 退勤が22時ー24時に含まれるか
        if midnight_b.cover?(work_out)
          midnight_work += work_out.in_time_zone - work_22.in_time_zone
          return midnight_work
        # それ以外（退勤が -22時）
        else
          return midnight_work
        end
      end
    else
      #　出勤が00時−05時に含まれるか
      if midnight_a.cover?(work_in)
        midnight_work += work_5.in_time_zone - work_in.in_time_zone
        # 退勤が24時-29時に含まれるか
        if midnight_c.cover?(work_out)
          midnight_work += work_out.in_time_zone - work_22.in_time_zone
          # 退勤が46時~48時に含まれるか
        elsif midnight_d.cover?(work_out)
            midnight_work += work_29.in_time_zone - work_22.in_time_zone
            midnight_work += work_out.in_time_zone - work_46.in_time_zone
        else
            midnight_work += work_29.in_time_zone - work_22.in_time_zone
        end
          return midnight_work
      # 出勤が22時~24時に含まれるか
      elsif midnight_b.cover?(work_in)
        # 退勤が24時~05時に含まれるか
        if midnight_c.cover?(work_out)
          midnight_work = work_out.in_time_zone - work_in.in_time_zone
          # 退勤が46時~48時に含まれるか
        elsif midnight_d.cover(work_out)
            midnight_work = work_29.in_time_zone - work_in.in_time_zone
            midnight_work += work_out.in_time_zone - work_46.in_time_zone
        else
            midnight_work = work_29.in_time_zone - work_in.in_time_zone
        end
          return midnight_work
      else
        # 退勤が24時~05時に含まれているか
        if midnight_c.cover?(work_out)
          midnight_time = work_out.in_time_zone - work_22.in_time_zone
        # 退勤が46時~48時に含まれるか
        elsif midnight_d.cover?(work_out)
          midnight_time = work_29.in_time_zone - work_22.in_time_zone
          midnight_time += work_out.in_time_zone - work_46.in_time_zone
        else
          midnight_time = work_29.in_time_zone - work_22.in_time_zone
        end
          return midnight_time
      end
    end
  end

end
