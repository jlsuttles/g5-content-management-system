require "simplecov"
SimpleCov.start

ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
require "capybara/rails"
require "rspec/rails"
require "capybara/rspec"
require "database_cleaner"
require "webmock/rspec"

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.order = "random"
  config.include Capybara::DSL, type: :request

  config.before(:all, type: :request) do
    WebMock.disable_net_connect!(:allow_localhost => true)
  end

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
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

  config.before(:each) do
    Widget.stub(:garden_url) { "spec/support/widgets.html" }
    WebTheme.stub(:garden_url) { "spec/support/themes.html" }
    WebLayout.stub(:garden_url) { "spec/support/layouts.html" }
  end
end

def drag_and_drop(source, target)
  builder = page.driver.browser.action
  source = source.native
  target = target.native

  builder.click_and_hold source
  builder.move_to        target, 1, 11
  builder.move_to        target
  builder.release        target
  builder.perform
end
