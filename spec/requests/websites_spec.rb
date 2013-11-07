require "spec_helper"

describe "website requests", js: true, vcr: VCR_OPTIONS do
  before do
    @client = Fabricate(:client)
    @location = Fabricate(:location)
    @website = Fabricate(:website, location_id: @location.id)
  end

  context "#show" do
    before do
      visit root_path
      click_link "Edit"
    end

    it "should have content" do
      page.should have_content @client.name.upcase
      page.should have_content @website.name.upcase
    end

    it "goes to edit when I click edit link" do
      within ".site-pages .cards .card .flipper .front .card-body .buttons" do
        click_link "Edit"
      end
      current_path.should eq "/website/#{@website.id}"
    end
  end
end
