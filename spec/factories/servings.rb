require 'Faker'

FactoryGirl.define do
  factory :serving do
    day_order 1
    quantity { 1 + Random.rand(5) }
    sequence(:name) { |n| "food#{n}" }
    calories { 150 + Random.rand(150)*5 }
    when_eaten { Date.today - Random.rand(7).days }
  end
end
