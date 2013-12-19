#
# IMPORTANT!
#
# The VCR gem records HTTP interactions to
# /spec/support/vcr_cassettes/web_template_requests
#
# If you want to record new interactions, delete these files.
#
# For more testing ideas, see https://github.com/jnicklas/capybara#the-dsl
# For other debugging ideas, see https://github.com/jnicklas/capybara#debugging
#
# Notes on `save_and_open_page`
#
# Due to the Rails asset pipeline, it does not work well, even with this fix
# http://stackoverflow.com/questions/13484808/save-and-open-page-not-working-with-capybara-2-0
#
# Notes on `page.save_screenshot('screenshot.png')`
#
# It works great! Use it. But only in development, do not push to Github.
#

require "spec_helper"

def set_setting(web_template, widget_name, setting_name, setting_value)
  widget = web_template.widgets.where(name: widget_name).first
  raise "Did not find '#{widget_name}' widget for web template '#{web_template.name}'" unless widget
  setting = widget.settings.where(name: setting_name).first
  raise "Did not find '#{setting_name}' setting for widget '#{widget_name}'" unless setting
  setting.update_attributes(value: setting_value)
end

describe "Integration '/web_template/:id'", js: true, vcr: VCR_OPTIONS do
  describe "Renders preview of compiled web template" do
    before do
      @client = Fabricate(:client)
      @location = Fabricate(:location)
    end

    describe "website_instructions/example.yml" do
      before do
        @instructions = YAML.load_file("#{Rails.root}/spec/support/website_instructions/example.yml")
        @website = WebsiteSeeder.new(@location, @instructions["website"]).seed
        @web_page_template = @website.web_page_templates.first
        set_setting(@web_page_template, "Social Links", "twitter_username", "jlsuttles")
        visit web_template_path(@web_page_template.id)
      end

      it "has web template title in title tag" do
        expect(page).to have_title @web_page_template.title
      end

      it "displays title in h1 tag in main section" do
        within "#drop-target-main h1" do
          expect(page).to have_content @web_page_template.title
        end
      end

      it "displays name in navigation widget in nav section" do
        within "#drop-target-nav .navigation.widget" do
          expect(page).to have_content @web_page_template.name.upcase
        end
      end

      it "displays name in navigation widget in footer section" do
        within "#drop-target-footer .navigation.widget" do
          expect(page).to have_content @web_page_template.name.upcase
        end
      end

      it "has a link to twitter with the set username in social links widget" do
        within "#drop-target-main .social-links.widget" do
          page.should have_selector "a[href='http://www.twitter.com/jlsuttles']"
        end
      end
    end
  end
end
