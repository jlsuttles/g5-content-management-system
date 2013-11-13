LOCATION_SELECTOR = ".faux-table .faux-table-row:first-of-type .buttons"
WEB_HOME_SELECTOR = ".cards .card:first-of-type"
WEB_PAGE_SELECTOR = ".cards .card:last-of-type"

def seed(file="example.yml")
  client = Fabricate(:client)
  location = Fabricate(:location)
  instructions = YAML.load_file("#{Rails.root}/spec/support/website_instructions/#{file}")
  website = WebsiteSeeder.new(location, instructions["website"]).seed
  [client, location, website]
end

def visit_website
  # Navigate to Ember application page
  # TODO: Get deep linking working for testing.
  visit "/"
  within LOCATION_SELECTOR do
    click_link "Edit"
  end
end

def visit_web_home_template
  # Navigate to Ember application page
  # TODO: Get deep linking working for testing.
  visit_website
  within WEB_HOME_SELECTOR do
    click_link "Edit"
  end
end

def visit_web_page_template
  # Navigate to Ember application page
  # TODO: Get deep linking working for testing.
  visit_website
  within WEB_PAGE_SELECTOR do
    click_link "Edit"
  end
end
