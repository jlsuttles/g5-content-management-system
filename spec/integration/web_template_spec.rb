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
  widget = web_template.widgets.joins(:garden_widget).where("garden_widgets.name" => widget_name).first
  raise "Did not find '#{widget_name}' widget for web template '#{web_template.name}'" unless widget
  setting = widget.settings.where(name: setting_name).first
  raise "Did not find '#{setting_name}' setting for widget '#{widget_name}'" unless setting
  setting.update_attributes(value: setting_value)
end

describe "Integration '/web_template/:id'", js: true, vcr: VCR_OPTIONS do
  describe "Renders preview of compiled web template" do
    describe "website_instructions" do
      before do
        VCR.use_cassette("Gardens") do
          GardenWebLayoutUpdater.new.update_all
          GardenWebThemeUpdater.new.update_all
          GardenWidgetUpdater.new.update_all
        end

        @client = Fabricate(:client)
        @location = Fabricate(:location)
        @website = WebsiteSeeder.new(@location).seed
        @web_page_template = @website.web_page_templates.first
      end

      describe "When settings are not set" do
        before do
          visit @web_page_template.url
        end

        it "has web template title in title tag" do
          expect(page).to have_title @web_page_template.title
        end

        it "has a rel='canonical' link" do
          expect(page).to have_selector("link[rel=canonical][href='#{@web_page_template.page_url}']", visible: false)
        end

        it "displays name in navigation widget in nav section" do
          pending "Capybara finds the selector locally but not on CI."
          within "#drop-target-nav .navigation.widget" do
            expect(page).to have_content @web_page_template.name.upcase
          end
        end

      end

      describe "When settings are set" do
        before do
          set_setting(@web_page_template, "HTML", "text", "enter text here")
          visit @web_page_template.url
        end

        it "has some text set in the HTML widget" do
          within first("#drop-target-main .html.widget") do
            page.should have_content "enter text here"
          end
        end
      end

      describe "Liquid parsing in settings" do
        it "correctly parses Liquid and displays title" do
          @web_page_template.update_attributes!(title: "{{ location_name }} {{ location_state }} {{ web_template_slug }}")
          visit @web_page_template.url
          expect(page).to have_title "#{@location.name} #{@location.state} #{@web_page_template.name}"
        end
      end

    end
  end
end
