namespace :db do
  desc "Try to fix any data problems in the database."
  task fixup: :environment do
    Serving.fixup_all_day_orders
  end
end
