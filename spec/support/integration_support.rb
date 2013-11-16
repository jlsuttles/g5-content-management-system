LOCATION_SELECTOR = ".location:first-of-type"
WEB_HOME_SELECTOR = ".web-home-template:first-of-type"
WEB_PAGE_SELECTOR = ".web-page-template:first-of-type"

def drag_and_drop(source, target)
  builder = page.driver.browser.action
  source = source.native
  target = target.native

  builder.click_and_hold source
  builder.move_to        target, 1, 11
  builder.move_to        target
  builder.release        target
  builder.perform
end

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
