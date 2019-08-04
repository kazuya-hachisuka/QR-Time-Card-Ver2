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

require 'test_helper'

class WorkBreakTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
