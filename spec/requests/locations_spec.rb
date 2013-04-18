require "requests_helper"

describe "locations requests", js: true do
  before do
    @client = Fabricate(:client)
    @location = Fabricate(:location)
  end

  context "#index" do
    before do
      visit locations_path
    end
    it "should have content" do
      page.should have_content @client.name.upcase
      page.should have_content @location.name
    end
  end

  context "#show" do
    before do
      visit location_path(@location)
    end
    it "should have content" do
      page.should have_content @client.name.upcase
      page.should have_content @location.name.upcase
      page.should have_content "Site Template"
      page.should have_content "Home"
    end
    it "goes to site_templates#edit when I click edit link" do
      within "table tbody tr:first-child" do
        click_link "Edit"
      end
      current_path.should eq edit_location_site_template_path(@location, @location.site_template)
    end
    it "goes to page_templates#edit when I click edit link" do
      within "table tbody tr:last-child" do
        click_link "Edit"
      end
      current_path.should eq edit_location_page_path(@location, @location.pages.first)
    end
  end
end
