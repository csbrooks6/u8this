namespace :db do
  desc "Try to fix any data problems in the database."
  task fixup: :environment do

    ### Servings ###

    # Find any invalid servings and remove them.
    invalid_serving_count = destroy_invalid_records Serving

    # Fix day orders.
    Serving.fixup_all_day_orders

    # In case somehow that made some Servings invalid, purge again.
    invalid_serving_count += destroy_invalid_records Serving

    puts "Serving: #{Serving.all.count} valid, #{invalid_serving_count} invalid (destroyed)"


    ### Foods ###

    # Start with all ref_counts at 0.
    Food.all.each do |f| 
      f.ref_count = 0
    end

    # Sort so that later eaten foods will stamp last_unit_calories later
    Serving.all.order(:user_id, :name, :when_eaten).each do |s|
      next unless s.valid?

      Food.addref(s.user, s.name, (s.calories.to_f / s.quantity))
    end

    invalid_food_count = destroy_invalid_records Food
    puts "Food: #{Food.all.count} valid, #{invalid_food_count} invalid (destroyed)"
  end

end

# Destroy all records of this class that aren't valid.
# Returns the number destroyed.
def destroy_invalid_records cls
  to_destroy = []
  cls.all.each do |r|
    to_destroy << r unless r.valid?
  end
  to_destroy.each do |r| 
    r.destroy
  end

  to_destroy.length
end
