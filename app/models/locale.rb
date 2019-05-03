# == Schema Information
#
# Table name: locales
#
#  id          :bigint           not null, primary key
#  locale_name :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_locales_on_locale_name  (locale_name)
#

class Locale < ApplicationRecord
end