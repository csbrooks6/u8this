namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    # Create some fake users.
    50.times do
      FactoryGirl.create :user
    end

    main_user = FactoryGirl.create :user, username: 'chris', email: 'chris@brooks6.com'

    # Create a bunch of serings.
    50.times do 
      FactoryGirl.create :serving, user: main_user
    end
  end
end
