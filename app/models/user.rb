class User < ActiveRecord::Base
  # For AuthLogic
  acts_as_authentic

  #validates_presence_of :login
  #validates_uniqueness_of :login

  #validates_presence_of :email
  #validates_uniqueness_of :email

  #validates :daily_calorie_goal, numericality: { greater_than_or_equal_to: 0 }    

  has_many :serving
end
