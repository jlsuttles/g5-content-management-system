source "https://rubygems.org"
ruby "1.9.3"

gem "rails", "~> 3.2.14"
gem "jquery-rails", "~> 3.0.4"
gem "jquery-ui-rails", "~> 4.0.5"

gem "strong_parameters"

gem "quiet_assets", "~> 1.0.1"
gem "bootstrap-sass", "~> 2.1.1.0"
gem "bourbon", "~> 3.1.8"
gem "heroku_resque_autoscaler", "~> 0.1.0"
gem "microformats2", "2.0.0.pre5"
gem "github_heroku_deployer", "~> 0.2.0"
gem "g5_sibling_deployer_engine", "~> 0.2.5"
gem "liquid", "~> 2.4.1"
gem "ckeditor"
gem "draper", "~> 1.1.0"
gem "coffee-script"
gem "ranked-model"
gem "aws-sdk", "~> 1.34.1"
gem "httparty"

gem "ember-rails"
gem "ember-source", "~> 1.0.0"
gem "ember-data-source", "~> 0.14"

group :assets do
  gem "sass-rails", "~> 3.2.3"
  gem "coffee-rails", "~> 3.2.1"
  gem "uglifier", ">= 1.0.3"
end

group :development do
  gem "better_errors", "~> 0.2.0"
  gem "binding_of_caller", "~> 0.6.8"
  gem "railroady"
end

group :development, :test do
  # secrets
  gem "dotenv-rails", "~> 0.9.0"
  # debugging
  gem "pry", "~> 0.9.12.2"
  # database
  gem "sqlite3", "~> 1.3.8"
  gem "rails-default-database", "~> 1.0.6"
  # ruby specs
  gem "rspec-rails", "~> 2.11.4"
  gem "shoulda-matchers", "~> 2.0.0"
  # ruby request specs
  gem "capybara", "~> 2.1.0"
  gem "launchy"
  gem "selenium-webdriver", "~> 2.35"
  gem "database_cleaner", "~> 0.9.1"
  # ruby spec support
  gem "fabrication", "~> 2.5.0"
  gem "faker"
  gem "webmock", "~> 1.13.0", require: false
  gem "vcr", "~> 2.6.0", require: false
  # javascript specs
  gem "teaspoon", "~> 0.7.5"
  # guard specs
  gem "guard-rspec", "~> 2.1.0"
  gem "rb-fsevent", "~> 0.9.2"
  # ruby spec coverage
  gem "simplecov", "~> 0.7.1", require: false
  gem "codeclimate-test-reporter", "~> 0.1.1", require: false
  gem "foreman"
end

group :production do
  gem "unicorn"
  gem "lograge"
  gem "pg"
  gem "rails_12factor"
  gem "newrelic_rpm"
  gem "dalli"
  gem "memcachier"
  gem "honeybadger"
end
