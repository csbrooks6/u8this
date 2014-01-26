class Serving < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :name
  validates :day_order, numericality: { greater_than_or_equal_to: 0 }  

  def quantity_as_str
    "%g" % quantity
  end
end
