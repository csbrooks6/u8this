require 'securerandom'

FactoryGirl.define do
  factory :user do
    daily_calorie_goal { (1000 + Random.rand(20) * 50) }
    email { Faker::Internet.email }
    password { SecureRandom.hex(8) }
    password_confirmation { password }
  end
end
