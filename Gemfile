source 'https://rubygems.org'

gem 'rails', '3.2.9'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'
group :production do
  gem 'pg'
  gem 'newrelic_rpm'
end

gem 'carrierwave'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :test, :development do
  gem 'steak'
  gem 'nokogiri'
  gem 'xpath'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'sqlite3'
  gem 'rake'
  gem 'simplecov', :require => false
  gem 'shoulda-matchers'
end

group :development do
  gem 'guard-rspec'
  gem 'rb-fsevent'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

gem 'thin'
gem 'twitter-bootstrap-rails'
gem 'less-rails'
