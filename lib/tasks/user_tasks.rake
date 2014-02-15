
# TODO: Some tests would be nice!

namespace :user do
  desc "List basic information about all users"
  task list: :environment do
    users = User.all.order(:email)

    format = "%30s|%11s|%25s|%5s|"
    puts format % ["email", "login_count", "last_login_at", "admin"]
    puts "-" * 80
    users.each do |u|
      puts format % [u.email, u.login_count, u.last_login_at, u.admin]
    end
  end

  desc "Show detailed information about a user"
  task :show, [:email] => [:environment] do |t, args|
    if args.email.nil?
      puts "USAGE: 'rake %s[bob@bob.com]'" % [t.name]
      next
    end

    user = User.find_by(email: args.email)
    if user.nil?
      puts "%s: Can't find User with email '%s'" % [t.name, args.email]
      next
    end

    User.attribute_names.each do |a|
      puts "%20s: %s" % [a, user[a]]
    end
  end

  desc "Delete a user"
  task :delete, [:email] => [:environment] do |t, args|
    if args.email.nil?
      puts "USAGE: 'rake %s[bob@bob.com]'" % [t.name]
      next
    end

    user = User.find_by(email: args.email)
    if user.nil?
      puts "%s: Can't find User with email '%s'" % [t.name, args.email]
      next
    end

    if user.admin
      puts "%s: Can't delete admin users (set_admin on %s to 0 first)" % [t.name, args.email]
      next
    end

    user.destroy
    puts "%s: Deleted user %s" % [t.name, args.email]
  end


  desc "Set the admin flag on a user"
  task :set_admin, [:email, :admin] => [:environment] do |t, args|
    if (args.email.nil? || args.admin.nil? || (!args.admin.in?(['0', '1'])) )
      puts "USAGE: 'rake %s[bob@bob.com,1]'" % [t.name]
      next
    end

    user = User.find_by(email: args.email)
    if user.nil?
      puts "%s: Can't find User with email '%s'" % [t.name, args.email]
      next
    end

    user.admin = args.admin
    user.save!
  end


end
