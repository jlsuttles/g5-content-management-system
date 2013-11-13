require "spec_helper"

describe "Integration '/website/:id'", js: true, vcr: VCR_OPTIONS do
  describe "Lists all web templates" do
    before do
      @client, @location, @website = seed
      @web_home_template = @website.web_home_template
      @web_page_template = @website.web_page_templates.first
      visit_website
    end

    it "Displays client, location, and page names" do
      within "header" do
        page.should have_content @client.name.upcase
        page.should have_content @location.name.upcase
      end

      within WEB_HOME_SELECTOR do
        page.should have_content @web_home_template.name.upcase
      end

      within WEB_PAGE_SELECTOR do
        page.should have_content @web_page_template.name.upcase
      end
    end

    it "Home 'Edit' link goes to '/location/:location_id/home/:home_id'" do
      within WEB_HOME_SELECTOR do
        click_link "Edit"
      end

      current_path.should eq "/location/#{@location.id}/home/#{@web_home_template.id}"
    end

    it "Page 'Edit' link goes to '/location/:location_id/page/:page_id'" do
      within WEB_PAGE_SELECTOR do
        click_link "Edit"
      end

      current_path.should eq "/location/#{@location.id}/page/#{@web_page_template.id}"
    end
  end
end
