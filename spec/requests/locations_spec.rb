require "spec_helper"

describe "locations requests", js: true do
  before do
    @client = Fabricate(:client)
    @location = Fabricate(:location)
    @website = @location.website
  end

  context "#index" do
    before do
      visit locations_path
    end
    it "should have content" do
      page.should have_content @client.name.upcase
      page.should have_content @location.name
      page.should have_content @website.name
    end
  end
end
