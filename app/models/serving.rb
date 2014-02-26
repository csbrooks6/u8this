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

class Serving < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user, :day_order, :name, :quantity, :name, :calories, :when_eaten
  validates :day_order, numericality: { greater_than_or_equal_to: 0 }  
  validates :quantity, numericality: { greater_than: 0 }  
  validates :calories, numericality: { greater_than: 0 }  

  def quantity_as_str
    if quantity.nil?
      return "-"
    end
    "%g" % quantity
  end

  def move_up
    # Find the Serving above us.
    prev = Serving.where(user_id: user_id, when_eaten: when_eaten, day_order: day_order - 1).first!

    # Swap day_order with it.
    prev.day_order += 1
    self.day_order -= 1
    prev.save
    save

    assert(Serving.check_day_orders(user_id, when_eaten))
  end

  def move_down
    # Find the Serving after us.
    after = Serving.where(user_id: user_id, when_eaten: when_eaten, day_order: day_order + 1).first!

    # Swap day_order with it.
    after.day_order -= 1
    self.day_order += 1
    after.save
    save

    assert(Serving.check_day_orders(user_id, when_eaten))
  end

  # Return an in-order array of all the Servings for the given user and day.
  def self.find_servings_for_user_for_day user_id, when_eaten
    Serving.where(user_id: user_id, when_eaten: when_eaten).order(:day_order, :name)
  end

  # Check day_orders in order, start at 0, no gaps.
  # Returns true if everything was ok, false if not.
  def self.check_day_orders user_id, when_eaten
    servings = Serving.find_servings_for_user_for_day(user_id, when_eaten)
    ord = 0
    servings.each do |s|
      return false unless s.day_order == ord
      ord += 1
    end

    true
  end


  # If the day_order field data isn't correct (starts at 0, no gaps), this will fix it up as best it can.
  # Returns true if everything was ok, false if not.
  def self.fixup_day_orders user_id, when_eaten
    ok = true

    servings = Serving.find_servings_for_user_for_day(user_id, when_eaten)
    ord = 0
    servings.each do |s|
      if s.day_order != ord
        s.day_order = ord
        s.save
        ok = false

        puts "Fixed " + s.inspect
      end

      ord += 1
    end

    ok
  end

  # Try to fixup ALL the day_orders across all users and days. 
  def self.fixup_all_day_orders 
    # This all could probably be made into one query, but it should only run in development.
    ok = true
    user_ids = Serving.pluck('DISTINCT user_id')
    user_ids.each do |user_id|
      dates = Serving.where(user_id: user_id).pluck('DISTINCT when_eaten')
      dates.each do |when_eaten|
        unless Serving.fixup_day_orders user_id, when_eaten
          ok = false
        end
      end
    end

    ok
  end

end
