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

# This describes a food someone ate at some point, for autocomplete purposes.
#
# It's separated per-user, so something one user ate won't autocomplete for a different user.
# The ref_count reflects how many Servings reference this Food; if this goes to 0, the Food 
# is deleted.
# The last_unit_calories is the number of calories they entered last time they created or updated
# one of these Foods. We just care about the last one edited/entered, not that it's still around,
# or that it was eaten most recently. (This is good enough for autocomplete, and simpler.)
class Food < ActiveRecord::Base
  belongs_to :user

  validates :ref_count, numericality: { greater_than_or_equal_to: 1 }

  # Increase ref_count by one. (Create the food if necessary.)
  # Also updates the last_unit_calories. 
  def self.addref user, food_name, last_unit_calories
    food = Food.find_by(user: user, name: food_name)
    if food.nil?
      food = Food.create(user: user, name: food_name, last_unit_calories: last_unit_calories, ref_count: 1)
    else
      food.ref_count += 1
      food.last_unit_calories = last_unit_calories
      food.save
    end
  end

  # Decrease ref_count by one, delete this Food if at 0.
  def self.release user, food_name
    food = Food.find_by(user: user, name: food_name)
    unless food.nil?
      food.ref_count -= 1
      food.destroy if food.ref_count <= 0
    end
  end

end
