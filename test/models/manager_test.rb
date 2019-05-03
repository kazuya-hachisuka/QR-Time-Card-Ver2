# == Schema Information
#
# Table name: managers
#
#  id                     :bigint           not null, primary key
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  family_name            :string           not null
#  family_name_kana       :string           not null
#  given_name             :string           not null
#  given_name_kana        :string           not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  locale                 :integer          not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  admin_id               :integer          not null
#
# Indexes
#
#  index_managers_on_admin_id              (admin_id)
#  index_managers_on_email                 (email) UNIQUE
#  index_managers_on_family_name           (family_name)
#  index_managers_on_family_name_kana      (family_name_kana)
#  index_managers_on_given_name            (given_name)
#  index_managers_on_given_name_kana       (given_name_kana)
#  index_managers_on_locale                (locale)
#  index_managers_on_reset_password_token  (reset_password_token) UNIQUE
#

require 'test_helper'

class ManagerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
