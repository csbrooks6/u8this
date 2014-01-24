# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    daily_calorie_goal { (1000 + Random.rand(20) * 50) }
    username { Faker::Internet.user_name }
    email { Faker::Internet.email username }
  end
end
