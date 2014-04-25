require 'spec_helper'

WEBSITE_DEFAULTS_APARTMENTS = YAML.load_file("#{Rails.root}/spec/support/defaults.yml")

describe WebsiteSeeder, vcr: VCR_OPTIONS do
  before do
    GardenWidgetUpdater.new.update_all
    @client = Fabricate(:client)
    @location = Fabricate(:location)
    @client.locations << @location
    @seeder = WebsiteSeeder.new(@location)
  end
  it "calls create_setting!" do
    @seeder.should_receive(:create_setting!).exactly(21).times
    @seeder.seed
  end
  it "overrides widget setting defaults if in yml file" do
    @seeder.seed
    @location.website.widgets[1].settings.find_by_name("google_plus_id").value.
      should == "the google plus id"
  end 
end

