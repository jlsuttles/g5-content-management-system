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
    it "locations#index when I click deploy link" do
      Resque.stub(:enqueue)
      within ".fauxTable .fauxTable-row:first-child" do
        click_link "Deploy"
      end
      current_path.should eq locations_path
    end
  end
end
