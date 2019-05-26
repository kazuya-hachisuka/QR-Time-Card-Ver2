# == Schema Information
#
# Table name: locales
#
#  id              :bigint           not null, primary key
#  control_number  :string(191)      not null
#  locale_name     :string(191)      not null
#  password_digest :string(191)      not null
#  remember_token  :string(191)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  admin_id        :integer          not null
#
# Indexes
#
#  index_locales_on_admin_id        (admin_id)
#  index_locales_on_control_number  (control_number)
#  index_locales_on_locale_name     (locale_name)
#

class Locale < ApplicationRecord
  #passwordの入力必須
  has_secure_password validations: true
  #admin_idが同じ場合にcontroller_numberをunique: trueにしたい
  #validates :
  validates :admin_id,presence: true

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA256.hexdigest(token.to_s)
  end

  belongs_to :admin
  has_one :manager, through: :admin
end
