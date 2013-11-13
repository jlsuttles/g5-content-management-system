require "spec_helper"

describe "Integration '/location/:location_id/page/:page_id'", js: true, vcr: VCR_OPTIONS do
  describe "Main widgets are drag and drop sortable" do
    before do
      @client, @location, @website = seed
      @web_page_template = @website.web_page_templates.first
      @widget1 = @web_page_template.main_widgets.first
      @widget2 = @web_page_template.main_widgets.last

      # Make sure widgets are ordered first and last
      @widget1.update_attribute :display_order, :first
      @widget2.update_attribute :display_order, :last

      visit_web_page_template
    end

    it "Updates database" do
      within ".main-widgets" do
        # Given .main-widgets has exactly two .widget
        widget1 = all(".widget").first
        widget2 = all(".widget").last
        expect(@widget2.display_order > @widget1.display_order).to be_true
        widget2.drag_to(widget1)
        expect(@widget2.display_order < @widget1.display_order).to be_true
      end
    end
  end

  describe "Sidebar widgets are drag and drop sortable" do
    before do
      @client, @location, @website = seed
      @website_template = @website.website_template
      @widget1 = @website_template.aside_widgets.first
      @widget2 = @website_template.aside_widgets.last
      @web_page_template = @website.web_page_templates.first

      # Make sure widgets are ordered first and last
      @widget1.update_attribute :display_order, :first
      @widget2.update_attribute :display_order, :last

      visit_web_page_template
    end

    it "Updates database" do
      within ".aside-widgets" do
        # Given .main-widgets has exactly two .widget
        widget1 = all(".widget").first
        widget2 = all(".widget").last
        expect(@widget2.display_order > @widget1.display_order).to be_true
        widget2.drag_to(widget1)
        expect(@widget2.display_order < @widget1.display_order).to be_true
      end
    end
  end
end
