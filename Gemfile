source 'https://rubygems.org'
ruby "2.0.0"

gem 'solid_assert', '0.7.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

# Use sqlite3 as the database for Active Record
gem 'sqlite3'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Fixes jquery event bind crappiness caused by turbolinks.
gem 'jquery-turbolinks'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# Bootstrap! See https://github.com/twbs/bootstrap-sass
gem 'bootstrap-sass', '~> 3.0.3.0'

# Authlogic, please.
gem 'authlogic', '~> 3.3.0' 

gem 'faker', "~> 1.2.0"

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
gem 'rvm1-capistrano3', require: false
gem 'capistrano', '~> 3.1'
gem 'capistrano-rails', '~> 1.1'

# Use debugger
# gem 'debugger', group: [:development, :test]

group:development,:test,:staging do
  gem "rspec-rails", "~> 2.14.0"
  gem "factory_girl_rails", "~> 4.2.1"
end

group:test do
  gem "capybara", "~> 2.1.0"
  gem "database_cleaner", "~> 1.0.1"
  gem "launchy", "~> 2.3.0"
  gem "selenium-webdriver", "~> 2.35.1"
end

group:staging,:production do
  gem "pg"
end
