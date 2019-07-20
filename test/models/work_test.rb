# == Schema Information
#
# Table name: works
#
#  id         :bigint           not null, primary key
#  in         :datetime         not null
#  out        :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  locael_id  :integer          not null
#  staff_id   :integer          not null
#
# Indexes
#
#  index_works_on_locael_id  (locael_id)
#  index_works_on_staff_id   (staff_id)
#

require 'test_helper'

class WorkTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
