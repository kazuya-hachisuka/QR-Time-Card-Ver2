# == Schema Information
#
# Table name: staffs
#
#  id               :bigint           not null, primary key
#  family_name      :string           not null
#  family_name_kana :string           not null
#  given_name       :string           not null
#  given_name_kana  :string           not null
#  qrcode           :text
#  status           :integer          default(0), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  admin_id         :integer          not null
#  locale_id        :integer          not null
#
# Indexes
#
#  index_staffs_on_family_name       (family_name)
#  index_staffs_on_family_name_kana  (family_name_kana)
#  index_staffs_on_given_name        (given_name)
#  index_staffs_on_given_name_kana   (given_name_kana)
#  index_staffs_on_locale_id         (locale_id)
#

require 'test_helper'

class StaffTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
