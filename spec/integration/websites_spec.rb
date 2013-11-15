require "spec_helper"

describe "Integration '/:id'", js: true, vcr: VCR_OPTIONS do
  describe "Lists all web templates" do
    before do
      @client, @location, @website = seed
      @web_home_template = @website.web_home_template
      @web_page_template = @website.web_page_templates.first
      visit_website
# LOCATION_SELECTOR = ".faux-table .faux-table-row:first-of-type .buttons"
# PAGE_SELECTOR = ".cards .card:first-of-type"

# describe "Integration '/:id'", js: true, vcr: VCR_OPTIONS do
#   describe "Lists all web templates" do
#     before do
#       ClientReader.perform(ENV["G5_CLIENT_UID"])
#       WebsiteSeederJob.perform

#       @client = Client.first
#       @location = Location.first
#       @website = @location.website
#       @web_home_template = @website.web_home_template

#       visit root_path

#       within LOCATION_SELECTOR do
#         click_link "Edit"
#       end
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

    it "Home 'Edit' link goes to '/:location_slug/:home_slug'" do
      within WEB_HOME_SELECTOR do
        click_link "Edit"
      end

      current_path.should eq "/#{@web_home_template.location.slug}/#{@web_home_template.slug}"
    end

    it "Page 'Edit' link goes to '/:location_slug/:page_slug'" do
      within WEB_PAGE_SELECTOR do
        click_link "Edit"
      end

      # Capybara.default_wait_time = 5
      current_path.should eq "/#{@website.slug}/#{@web_home_template.slug}"
    end
  end
end
