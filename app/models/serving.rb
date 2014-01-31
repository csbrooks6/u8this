class Serving < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :name
  validates :day_order, numericality: { greater_than_or_equal_to: 0 }  

  def quantity_as_str
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
  end

  def move_down
    # Find the Serving after us.
    after = Serving.where(user_id: user_id, when_eaten: when_eaten, day_order: day_order + 1).first!

    # Swap day_order with it.
    after.day_order -= 1
    self.day_order += 1
    after.save
    save
  end

  # Return an in-order array of all the Servings for the given user and day.
  def self.find_servings_for_user_for_day user_id, when_eaten
    Serving.where(user_id: user_id, when_eaten: when_eaten).order(:day_order, :name)
  end

  # If the day_order field data isn't correct, this will fix it up as best it can, 
  # and return the number of Servings fixed. 
  # NOTE: If this returns >0, something is broken somewhere!
  def self.fixup_day_orders
    # (This all could probably be made into one query, but we almost never run this.)
    fixed_count = 0
    user_ids = Serving.pluck('DISTINCT user_id')
    user_ids.each do |user_id|
      dates = Serving.where(user_id: user_id).pluck('DISTINCT when_eaten')
      dates.each do |when_eaten|
        servings = Serving.find_servings_for_user_for_day user_id, when_eaten
        ord = 0
        servings.each do |s|
          if s.day_order != ord
            s.day_order = ord
            s.save
            fixed_count += 1
            puts "FIXED: "+s.inspect
          end

          ord += 1
        end
      end
    end

    fixed_count
  end
end
