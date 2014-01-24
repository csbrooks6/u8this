class User < ActiveRecord::Base
  validates_presence_of :username
  validates_uniqueness_of :username

  validates_presence_of :email
  validates_uniqueness_of :email

  validates :daily_calorie_goal, numericality: { greater_than_or_equal_to: 0 }    

  has_many :serving
end
