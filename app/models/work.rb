# == Schema Information
#
# Table name: works
#
#  id         :bigint           not null, primary key
#  in         :datetime         not null
#  out        :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  locale_id  :integer          not null
#  staff_id   :integer          not null
#
# Indexes
#
#  index_works_on_locale_id  (locale_id)
#  index_works_on_staff_id   (staff_id)
#

class Work < ApplicationRecord
  has_many :work_breaks, dependent: :destroy #関連するwork_breakも削除
  belongs_to :staff
  belongs_to :locale
end
