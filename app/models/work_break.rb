# == Schema Information
#
# Table name: work_breaks
#
#  id         :bigint           not null, primary key
#  in         :datetime         not null
#  out        :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  work_id    :integer          not null
#
# Indexes
#
#  index_work_breaks_on_work_id  (work_id)
#

class WorkBreak < ApplicationRecord
  belongs_to :work

  def self.multi_update(work_break_params)
    work_break_params.to_h.map do |id, work_break_param|
      work_break = self.find(id)
      work_break.update_attributes!(work_break_param)
    end
  end
end
