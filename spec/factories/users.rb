# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  email               :string(255)      not null
#  crypted_password    :string(255)      not null
#  password_salt       :string(255)      not null
#  persistence_token   :string(255)      not null
#  single_access_token :string(255)      not null
#  perishable_token    :string(255)      not null
#  login_count         :integer          default(0), not null
#  failed_login_count  :integer          default(0), not null
#  last_request_at     :datetime
#  current_login_at    :datetime
#  last_login_at       :datetime
#  current_login_ip    :string(255)
#  last_login_ip       :string(255)
#  daily_calorie_goal  :integer          default(2000), not null
#  created_at          :datetime
#  updated_at          :datetime
#  admin               :boolean          default(FALSE), not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

require 'securerandom'

FactoryGirl.define do
  factory :user do
    daily_calorie_goal { (1000 + Random.rand(20) * 50) }
    email { Faker::Internet.email }
    password { SecureRandom.hex(8) }
    password_confirmation { password }
  end
end
