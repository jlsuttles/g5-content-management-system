require "spec_helper"

describe "Integration '/:id'", js: true, vcr: VCR_OPTIONS do
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

    it "Home 'Edit' link goes to '/:website_slug/:home_slug'" do
      within WEB_HOME_SELECTOR do
        click_link "Edit"
      end

      current_path.should eq "/#{@web_home_template.website.slug}/#{@web_home_template.slug}"
    end

    it "Page 'Edit' link goes to '/:website_slug/:page_slug'" do
      within WEB_PAGE_SELECTOR do
        click_link "Edit"
      end

      current_path.should eq "/#{@website.slug}/#{@web_page_template.slug}"
    end
  end
end
