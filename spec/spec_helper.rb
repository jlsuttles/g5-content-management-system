if ENV["CODECLIMATE_REPO_TOKEN"]
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
require "rspec/rails"
require "capybara/rails"
require "capybara/rspec"
require 'capybara/poltergeist' if ENV["HEADLESS"]
require "database_cleaner"
require "webmock/rspec"
require "vcr"
require 'g5_authenticatable/rspec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema! if defined?(ActiveRecord::Migration)

VCR.configure do |config|
  config.cassette_library_dir = "spec/support/vcr_cassettes"
  config.hook_into :webmock
  config.ignore_hosts "127.0.0.1", "localhost", "codeclimate.com"
  config.configure_rspec_metadata!
end

VCR_OPTIONS = { record: :new_episodes, re_record_interval: 7.days }

RSpec.configure do |config|
  config.order = "random"
  config.include Capybara::DSL, type: :request

  # Allows us to  use :vcr rather than :vcr => true
  # In RSpec 3 this will no longer be necessary
  config.treat_symbols_as_metadata_keys_with_true_values = true

  # The integration deployment tests can be run with:
  # rspec -t type:deployment
  config.filter_run_excluding type: "deployment"

  config.before(:suite) do
    # Temporary fix for default_url_host not being properly set in Rails 4.1.0
    Rails.application.routes.default_url_options = { host: "localhost:3000", port: nil }
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
    set_selenium_window_size(1250, 800) if Capybara.current_driver == :selenium
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

Capybara.javascript_driver = :poltergeist if ENV["HEADLESS"]

def set_selenium_window_size(width, height)
  window = Capybara.current_session.driver.browser.manage.window
  window.resize_to(width, height)
end
