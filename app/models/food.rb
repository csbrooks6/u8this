# == Schema Information
#
# Table name: foods
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  name       :string(255)      not null
#  ref_count  :integer          default(0), not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_foods_on_user_id_and_name  (user_id,name)
#

class Food < ActiveRecord::Base
  belongs_to :user

  validates :ref_count, numericality: { greater_than_or_equal_to: 1 }

  # Increase ref_count by one. (Create the food if necessary.)
  def self.addref user, food_name
    food = Food.find_by(user: user, name: food_name)
    if food.nil?
      food = Food.create(user: user, name: food_name, ref_count: 1)
    else
      food.ref_count += 1
      food.save
    end
  end

  # Decrease ref_count by one, delete this Food if at 0.
  def self.release user, food_name
    food = Food.find_by(user: user, name: food_name)
    unless food.nil?
      food.ref_count -= 1
      if food.ref_count <= 0
        food.destroy
      end
    end
  end

end
