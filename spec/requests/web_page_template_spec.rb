require "spec_helper"

describe "web_page_templates requests", js: true do
  before do
    @client = Fabricate(:client)
    @location = Fabricate(:location)
    @website = @location.website
  end

  describe "#index" do
    describe "create new page link" do
      before do
        visit website_path(@website)
      end
      it "should go to the new page page" do
        click_link "Create New Page"
        current_path.should eq new_website_web_page_template_path(@website)
      end
    end
  end

  describe "#edit" do
    before do
      visit edit_website_web_page_template_path(@website, @website.web_page_templates.first)
    end
    it "should have content" do
      page.should_not have_content "Select a Layout".upcase
      page.should_not have_content "Select a Theme".upcase
      page.should_not have_content "Theme Colors".upcase
      page.should have_content "Select Widgets".upcase
    end
  end

  describe "#new" do
    before do
      visit new_website_web_page_template_path(@website)
    end
    it "should have content" do
      page.should have_content "Name".upcase
      page.should have_content "Slug".upcase
      page.should have_content "Page Title".upcase
    end
    it "should create a new web_page_template" do
      find("input#web_page_template_name").set("about mj")
      find("input#web_page_template_slug").set("about_mj")
      find("input#web_page_template_title").set("About MJ")
      click_button "Submit"
      current_path.should eq website_path(@website)
      page.should have_content "about mj".upcase
    end
  end
end
