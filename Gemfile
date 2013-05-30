source "https://rubygems.org"
source "https://gems.gemfury.com/88yeKzEGfizstwBaXVqj/"
ruby "1.9.3"

gem "rails", "3.2.13"
gem "jquery-rails"

gem "quiet_assets", "~> 1.0.1"
gem "bootstrap-sass", "~> 2.1.1.0"
gem "foreman", "~> 0.60.2"
gem "heroku_resque_autoscaler", "~> 0.1.0"
gem "microformats2", "2.0.0.pre4"
gem "github_heroku_deployer", "~> 0.2.0"
gem "g5_sibling_deployer_engine", "~> 0.2"
gem "liquid", "~> 2.4.1"
gem "ckeditor"
gem "draper", "~> 1.1.0"

gem "ember-rails"

group :assets do
  gem "sass-rails", "~> 3.2.3"
  gem "coffee-rails", "~> 3.2.1"
  gem "uglifier", ">= 1.0.3"
end

group :development do
  gem "better_errors", "~> 0.2.0"
  gem "binding_of_caller", "~> 0.6.8"
end

group :development, :test do
  gem "sqlite3"
  gem "rails-default-database", "~> 1.0.6"
  gem "capybara", "~> 2.1.0"
  gem "selenium-webdriver", "~> 2.32.1"
  gem "database_cleaner", "~> 0.9.1"
  gem "rspec-rails", "~> 2.11.4"
  gem "shoulda-matchers", "~> 2.0.0"
  gem "guard-rspec", "~> 2.1.0"
  gem "rb-fsevent", "~> 0.9.2"
  gem "debugger", "~> 1.2.1"
  gem "fabrication", "~> 2.5.0"
  gem "faker", "~> 1.1.2"
  gem "simplecov", :require => false
  gem "pry"
  gem "webmock", "~> 1.11.0", :require => false
  gem "jasmine"
  gem "jasminerice", :git => "https://github.com/bradphelan/jasminerice.git"
  gem "guard-jasmine"
end

group :production do
  gem "thin", "~> 1.5.0"
  gem "pg"
end
