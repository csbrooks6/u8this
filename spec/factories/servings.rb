# == Schema Information
#
# Table name: servings
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  day_order  :integer
#  quantity   :float
#  name       :string(255)
#  calories   :integer
#  when_eaten :date
#  created_at :datetime
#  updated_at :datetime
#

$random_portion = [
  'slices of ',
  'cups of ',
  'ounces of ',
  'pieces of ',
]

$random_foods = [
  'almonds',
  'apples',
  'bananas',
  'black berries',
  'blue berries',
  'bread',
  'broccoli',
  'carrots',
  'cashews',
  'cauliflower',
  'celery',
  'cereal',
  'cheese',
  'chicken',
  'coconuts',
  'corn',
  'crackers',
  'craisins',
  'cranberrys',
  'cream cheese',
  'cream of wheat',
  'cucumbers',
  'dried apricots',
  'eggs',
  'granola',
  'hash browns',
  'jelly',
  'lettuce',
  'oats',
  'okra',
  'oranges',
  'pasta',
  'peaches',
  'peanut butter',
  'peanuts',
  'pears',
  'peppers',
  'pickles',
  'pineapples',
  'plums',
  'popcorn',
  'radishes',
  'raisins',
  'raspberrys',
  'rice',
  'sandwiches',
  'snowcones',
  'spinach',
  'tacos',
  'tangerines',
  'yogurt',
]

FactoryGirl.define do
  factory :serving do
    day_order 0
    quantity { 1 + Random.rand(5) }
    sequence(:name) { $random_portion.sample + $random_foods.sample }
    calories { 50 + Random.rand(20)*10 }
    when_eaten { Date.today - Random.rand(7).days }
  end
end
