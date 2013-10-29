require "vcr"

class EmberFixtureGenerator
  FIXTURE_PATH = Rails.root.join("spec", "javascripts", "support", "fixtures.json")

  def self.generate
    # Perform in test ENV
    Rails.env = "test"
    # Send rails logs to STDOUT
    Rails.logger = Logger.new(STDOUT)

    require File.expand_path("../../config/environment", __FILE__)
    require "rspec/rails"
    require "webmock/rspec"
    require "vcr"
    require "json"

    VCR.configure do |config|
      config.cassette_library_dir = "spec/support/vcr_cassettes"
      config.hook_into :webmock
    end

    VCR.use_cassette("javascripts/spec_helper") do
      # Create records in Rails DB
      ClientReader.perform(ENV["G5_CLIENT_UID"])
      WebsiteSeederJob.perform
    end

    # config.action_mailer.deafult_url_options is set in
    # /config/environments/test.rb but still ends up nil and causes errors unless
    # set in this file.
    Rails.application.routes.default_url_options[:host] = "test.com"

    # Create attribute hash Ember FIXTURES can use
    @locations = []
    Location.all.each do |location|
      # serialize with ActiveModelSerializers
      location_serialize = LocationSerializer.new(location).as_json
      # remove the root key ':location' and any other root keys
      # location_hash = location_serialize[:location]
      location_hash = location_serialize[:location]
      # camelize keys to work with Ember FIXTURES
      @locations << camelize_keys(location_hash) if location_hash
    end

    open(FIXTURE_PATH, "w") do |file|
      file.write @locations.to_json
    end
  end

  # Convert keys from ruby object to camelized strings. e.g:
  # :hello_there_world becomes "helloThereWorld"
  def self.camelize_keys(object)
    r = {}
    object.to_hash.each do |k,v|
      r[k.to_s.camelize(:lower)] = v
    end
    r
  end

end
