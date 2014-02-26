# == Schema Information
#
# Table name: foods
#
#  id                 :integer          not null, primary key
#  user_id            :integer          not null
#  name               :string(255)      not null
#  ref_count          :integer          default(0), not null
#  created_at         :datetime
#  updated_at         :datetime
#  last_unit_calories :float            default(0.0), not null
#
# Indexes
#
#  index_foods_on_user_id_and_name  (user_id,name)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :food do
    user ""
    name "MyString"
    ref_count 1
  end
end
