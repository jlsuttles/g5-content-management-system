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

  describe "Web page templates are drag and drop sortable" do
    before do
      @client, @location, @website = seed
      @web_page_template1 = @website.web_page_templates.first
      @web_page_template2 = @website.web_page_templates.last

      # Make sure widgets are ordered first and last
      @web_page_template1.update_attribute :display_order, :first
      @web_page_template2.update_attribute :display_order, :last

      visit_website
      # HACK: Shouldn't have to do this, Capybara should be scrolling.
      scroll_to(page, ".sortable")
    end

    it "Updates database" do
      within ".sortable" do
        web_page_template1 = find(".sortable-item:first-of-type")
        web_page_template2 = find(".sortable-item:last-of-type")
        expect(@web_page_template2.display_order > @web_page_template1.display_order).to be_true
        web_page_template2.drag_to(web_page_template1)
        drag_and_drop(web_page_template1, web_page_template2)
        sleep 1
        expect(@web_page_template2.reload.display_order < @web_page_template1.reload.display_order).to be_true
      end
    end
  end
end