require "spec_helper"

describe "pages requests", js: true do
  before do
    @client = Fabricate(:client)
    @location = Fabricate(:location)
  end

  describe "#edit" do
    before do
      visit edit_location_page_path(@location, @location.pages.first)
    end
    it "should have content" do
      page.should_not have_content "Select a Layout".upcase
      page.should_not have_content "Select a Theme".upcase
      page.should_not have_content "Customize Colors".upcase
      page.should have_content "Select Widgets".upcase
    end
  end
end
