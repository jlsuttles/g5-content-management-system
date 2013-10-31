require "spec_helper"

LOCATION_SELECTOR = ".faux-table .faux-table-row"

describe "locations requests", js: true, vcr: VCR_OPTIONS do
  before do
    Resque.stub(:enqueue)

    @client = Fabricate(:client)
    @location = Fabricate(:location)
    @website = Fabricate(:website, location_id: @location.id)
    @location.reload
  end

  context "#index" do
    before do
      visit root_path
    end

    it "Client and location names are displayed" do
      within "header" do
        # CSS upcases this name, so we also upcase
        expect(page).to have_content(@client.name.upcase)
      end

      within LOCATION_SELECTOR do
        expect(page).to have_content(@location.name)
      end
    end

    it "'Deploy' link redirects back to root path" do
      within LOCATION_SELECTOR do
        click_link "Deploy"
      end

      expect(current_path).to eq(root_path)
    end

    it "'Edit' link goes to Ember App" do
      within LOCATION_SELECTOR do
        click_link "Edit"
      end

      within "header" do
        # CSS upcases these names, so we also upcase
        expect(page).to have_content(@client.name.upcase)
        expect(page).to have_content(@location.name.upcase)
      end

      expect(current_path).to eq("/website/#{@website.id}")
    end

    it "'View' link goes to Heroku App" do
      pending("capybara can't find the 'view' link because the href is being populated via bindAttr")
      within LOCATION_SELECTOR do
        click_link "View"
      end

      expect(page).to have_content("Heroku | No such app")
    end
  end
end
