namespace :db do
  desc "Try to fix any data problems in the database."
  task fixup: :environment do
    # Find any servings without owners and remove them.
    servings_to_destroy = []
    Serving.all.each do |s|
      if s.user.nil?
        servings_to_destroy << s
      end
    end
    puts "Found %d owner-less Servings; removing" % [servings_to_destroy.length]
    servings_to_destroy.each do |s| 
      s.destroy
    end

    Serving.fixup_all_day_orders
  end

  desc "Populate foods table"
  task make_foods: :environment do
    puts "%d Foods deleted" % [Food.all.count]
    Food.delete_all
    Serving.all.each do |s|
      if s.user.nil?
        puts "user-less Serving! " + s.inspect
        next
      end
      food = Food.find_by name: s.name, user: s.user
      if food.nil?
        food = Food.create name: s.name, user: s.user, ref_count: 1
      else
        food.ref_count += 1
        food.save
      end
    end

    puts "%d Foods created" % [Food.all.count]
  end

end
