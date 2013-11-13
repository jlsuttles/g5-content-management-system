require "spec_helper"

LOCATION_SELECTOR = ".faux-table .faux-table-row:first-of-type .buttons"
HOME_SELECTOR = ".cards .card:first-of-type"
PAGE_SELECTOR = ".cards .card:last-of-type"

describe "Integration '/website/:id'", js: true, vcr: VCR_OPTIONS do
  describe "Lists all web templates" do
    before do
      # Setup Rails database
      @client = Fabricate(:client)
      @location = Fabricate(:location)
      @instructions = YAML.load_file("#{Rails.root}/spec/support/website_instructions/example.yml")
      @website = WebsiteSeeder.new(@location, @instructions["website"]).seed
      @web_home_template = @website.web_home_template
      @web_page_template = @website.web_page_templates.first

      # Navigate to Ember application page
      # TODO: Get deep linking working for testing.
      visit "/"
      within LOCATION_SELECTOR do
        click_link "Edit"
      end
    end

    it "Displays client, location, and page names" do
      within "header" do
        page.should have_content @client.name.upcase
        page.should have_content @location.name.upcase
      end

      within HOME_SELECTOR do
        page.should have_content @web_home_template.name.upcase
      end

      within PAGE_SELECTOR do
        page.should have_content @web_page_template.name.upcase
      end
    end

    it "Home 'Edit' link goes to '/location/:location_id/home/:home_id'" do
      within HOME_SELECTOR do
        click_link "Edit"
      end

      current_path.should eq "/location/#{@location.id}/home/#{@web_home_template.id}"
    end

    it "Page 'Edit' link goes to '/location/:location_id/page/:page_id'" do
      within PAGE_SELECTOR do
        click_link "Edit"
      end

      current_path.should eq "/location/#{@location.id}/page/#{@web_page_template.id}"
    end
  end
end
