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
      page.should have_content @client.name.upcase
      page.should have_content @website.name.upcase
      page.should have_content "Website Template"
      page.should have_content "Home"
    end
    it "goes to website_templates#edit when I click edit link" do
      within "table tbody tr:first-child" do
        click_link "Edit"
      end
      current_path.should eq edit_website_website_template_path(@website, @website.website_template)
    end
    it "goes to web_home_templates#edit when I click edit link" do
      within "table tbody tr.webhometemplate" do
        click_link "Edit"
      end
      current_path.should eq edit_website_web_home_template_path(@website, @website.web_home_template)
    end
  end
end
