require "spec_helper"

describe "website requests", js: true, vcr: VCR_OPTIONS do
  before do
    @client = Fabricate(:client)
    @location = Fabricate(:location)
    @website = Fabricate(:website)
    @location.website = @website

    website_template = Fabricate(:website_template)
    web_layout = Fabricate(:web_layout)
    website_template.web_layout = web_layout
    web_theme = Fabricate(:web_theme)
    website_template.web_theme = web_theme

    web_home_template = Fabricate(:web_home_template)
    @web_page_template = Fabricate(:web_page_template)

    @website.website_template = website_template
    @website.web_home_template = web_home_template
    @website.web_page_templates << @web_page_template
  end

  context "#show" do
    before do
      visit website_path(@website)
    end

    it "should have content" do
      page.should have_content @web_page_template.name.upcase
      page.should have_content @client.name.upcase
      page.should have_content @website.name.upcase
    end

    it "goes to ember app when I click edit link" do
      within ".site-pages .cards .card:first-child .flipper .front .card-body .buttons" do
        click_link "Edit"
      end
      current_path.should eq "/ember/"
    end
  end
end
