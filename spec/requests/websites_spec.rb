require "spec_helper"

LOCATION_SELECTOR = ".faux-table .faux-table-row:first-of-type .buttons"
PAGE_SELECTOR = ".cards .card:first-of-type"

describe "integration /ember/#/website/4", js: true, vcr: VCR_OPTIONS do
  before do
    ClientReader.perform(ENV["G5_CLIENT_UID"])
    WebsiteSeederJob.perform

    @client = Client.first
    @location = Location.first
    @web_home_template = @location.website.web_home_template

    visit root_path

    within LOCATION_SELECTOR do
      click_link "Edit"
    end
  end

  it "Displays client, location, and page names" do
    Capybara.default_wait_time = 5
    within "header" do
      # CSS upcases these names, so we upcase
      page.should have_content @client.name.upcase
      page.should have_content @location.name.upcase
    end

    within PAGE_SELECTOR do
      page.should have_content @web_home_template.name.upcase
    end
  end

  it "'Edit' link goes to Ember App", vcr_options: { record: :new } do
    within PAGE_SELECTOR do
      click_link "Edit"
    end

    Capybara.default_wait_time = 5
    current_path.should eq "/location/#{@location.id}/home/#{@web_home_template.id}"
  end
end
