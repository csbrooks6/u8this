require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    # Create some fake users.

    5.times do
      FactoryGirl.create :user
    end

    User.all.each do |user|
      # For all days in the last week...
      ((Date.today-7)..(Date.today)).each do |day|
        # ... add some servings.
        (Random.rand(10) + 10).times do
          FactoryGirl.create :serving, user: user, when_eaten: day
        end
      end
    end
  end
end
