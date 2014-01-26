class User < ActiveRecord::Base
  # For AuthLogic
  acts_as_authentic

  validates :daily_calorie_goal, numericality: { greater_than_or_equal_to: 0 }    

  has_many :serving
end
