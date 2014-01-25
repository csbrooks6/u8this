require 'Faker'

FactoryGirl.define do
  factory :user do
    daily_calorie_goal { (1000 + Random.rand(20) * 50) }
    login { Faker::Internet.user_name }
    email { Faker::Internet.email login }
  end
end
