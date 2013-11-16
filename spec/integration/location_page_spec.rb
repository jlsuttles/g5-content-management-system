require "spec_helper"

describe "Integration '/:website_slug/:web_page_template_slug'", js: true, vcr: VCR_OPTIONS do
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
      # HACK: Shouldn't have to do this, Capybara should be scrolling.
      page.execute_script("window.scrollTo(0,1000);")
    end

    it "Updates database" do
      within ".main-widgets .sortable" do
        widget1 = find(".sortable-item:first-of-type")
        widget2 = find(".sortable-item:last-of-type")
        expect(@widget2.display_order > @widget1.display_order).to be_true
        drag_and_drop(widget1, widget2)
        sleep 1
        expect(@widget2.reload.display_order < @widget1.reload.display_order).to be_true
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
      # HACK: Shouldn't have to do this, Capybara should be scrolling.
      page.execute_script("window.scrollTo(0,1000);")
    end

    it "Updates database" do
      within ".aside-widgets .sortable" do
        widget1 = find(".sortable-item:first-of-type")
        widget2 = find(".sortable-item:last-of-type")
        expect(@widget2.display_order > @widget1.display_order).to be_true
        widget2.drag_to(widget1)
        drag_and_drop(widget1, widget2)
        sleep 1
        expect(@widget2.reload.display_order < @widget1.reload.display_order).to be_true
      end
    end
  end
end
