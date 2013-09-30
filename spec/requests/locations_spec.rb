require "spec_helper"

describe "locations requests", js: true, vcr: VCR_OPTIONS do
  before do
    Resque.stub(:enqueue)
    @client = Fabricate(:client)
    @location = Fabricate(:location)
    @website = Fabricate(:website)
    @location.website = @website
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
      within ".faux-table .faux-table-row:first-child" do
        click_link "Deploy"
      end
      current_path.should eq locations_path
    end
  end
end
