require "vcr"

class EmberFixtureGenerator
  FIXTURE_PATH = Rails.root.join("spec", "javascripts", "fixtures", "fixtures.json")

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
      config.cassette_library_dir = "spec/javascripts/support/vcr_cassettes"
      config.hook_into :webmock
    end

    VCR.use_cassette("spec_helper") do
      # Create records in Rails DB
      ClientReader.perform(ENV["G5_CLIENT_UID"])
      WebsiteSeederJob.perform
    end

    # config.action_mailer.deafult_url_options is set in
    # /config/environments/test.rb but still ends up nil and causes errors unless
    # set in this file.
    Rails.application.routes.default_url_options[:host] = "test.com"

    # serialize client with ActiveModelSerializers
    client_hash = ClientSerializer.new(Client.first).as_json
    # camelize keys to work with Ember FIXTURES
    client_hash_camelized = camelize_keys(client_hash)

    open(FIXTURE_PATH, "w") do |file|
      # file.write client_hash_camelized.to_json
      file.write JSON.pretty_generate(client_hash_camelized)
    end
  end

  # Convert keys from ruby object to camelized strings. e.g:
  # :hello_there_world becomes "helloThereWorld"
  def self.camelize_keys(object)
    r = {}
    # object = {"locations":[{},{}]}
    object.to_hash.each do |k,v|
      # v = [{},{}]
      if v.is_a? Array
        r[k.to_s.camelize(:lower)] = v.map do |vv|
          rrr = {}
          # vv = {"id":88}
          vv.to_hash.each do |kkk,vvv|
            rrr[kkk.to_s.camelize(:lower)] = vvv
          end
          rrr
        end
      else
          if vv.is_a? Array
            # vv = ["id", 88]
            rrr[] << vv[0].to_s.camelize(:lower) => vv[1]
          else
      end
    end
    r
  end
end
