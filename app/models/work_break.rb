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
end
