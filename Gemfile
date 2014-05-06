source "https://rubygems.org"
ruby "2.1.1"

gem "rails", github: "rails/rails", branch: "4-1-stable"
gem "jquery-rails"
gem "jquery-ui-rails"

gem "quiet_assets"
gem "bootstrap-sass"
gem "bourbon"
gem "heroku_resque_autoscaler"
gem "microformats2"
gem "github_heroku_deployer"
gem "g5_sibling_deployer_engine"
gem "liquid"
gem "ckeditor"
gem "draper"
gem "coffee-script"
gem "ranked-model"
gem "aws-sdk"
gem "httparty"

gem "ember-rails"
gem "ember-source", "~> 1.0.0"
gem "ember-data-source", "~> 0.14"

# Temporary fix
gem "sprockets", "=2.11.0"
gem "sass-rails"
gem "coffee-rails"
gem "uglifier"

group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem "railroady"
end

group :development, :test do
  # secrets
  gem "dotenv-rails"
  # debugging
  gem "pry"
  # database
  gem "sqlite3"
  # ruby specs
  gem "timecop"
  gem "rspec-rails"
  gem "shoulda-matchers"
  # ruby request specs
  gem "capybara"
  gem "launchy"
  gem "selenium-webdriver"
  gem "database_cleaner"
  # ruby spec support
  gem "fabrication"
  gem "faker"
  gem "webmock", require: false
  gem "vcr", require: false
  # ruby spec coverage
  gem "codeclimate-test-reporter", require: false
  # guard specs
  gem "guard-rspec", require: false
  gem "rb-fsevent"
  # server processes runner
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
