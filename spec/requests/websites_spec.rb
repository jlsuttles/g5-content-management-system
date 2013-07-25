require "spec_helper"

describe "website requests", js: true do
  before do
    @client = Fabricate(:client)
    @location = Fabricate(:location)
    @website = @location.website
  end

  context "#show" do
    before do
      visit website_path(@website)
    end
    it "should have content" do
      page.should have_content 'Home'.upcase
      page.should have_content @client.name.upcase
      page.should have_content @website.name.upcase
    end
    it "goes to web_home_templates#edit when I click edit link" do
      within ".site-pages .card:first-child .flipper .front .card-body .buttons" do
        click_link "Edit"
      end
      current_path.should eq "/ember/"
    end
  end
end
