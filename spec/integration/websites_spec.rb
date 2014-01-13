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
    end

    it "Updates database" do
      within ".web-page-templates" do
        web_page_template1 = find(".web-page-template:first-of-type")
        web_page_template2 = find(".web-page-template:last-of-type")
        expect(@web_page_template2.display_order > @web_page_template1.display_order).to be_true
        drag_and_drop(web_page_template1, web_page_template2)
        sleep 1
        expect(@web_page_template2.reload.display_order < @web_page_template1.reload.display_order).to be_true
      end
    end
  end

  describe "Web page templates can be dragged to the trash" do
    before do
      pending("Capybara can't handle this. It passes if page is manually zoomed out.")
      @client, @location, @website = seed
      visit_website
    end

    it "Updates database" do
      web_page_template = find(".web-page-templates .web-page-template:first-of-type")
      trash = find(".web-page-templates-in-trash")
      expect do
        drag_and_drop(web_page_template, trash)
        sleep 1
      end.to change{ WebPageTemplate.where(in_trash: true).count }.by(1)
    end
  end

  describe "Web page templates can be dragged out of the trash" do
    before do
      pending("Capybara can't handle this. It passes if page is manually zoomed out.")
      @client, @location, @website = seed
      @website.web_page_templates.first.update_attribute(:in_trash, true)
      visit_website
    end

    it "Updates database" do
      web_page_template = find(".web-page-templates-in-trash .web-page-template:first-of-type")
      not_trash = find(".web-page-templates")
      expect do
        drag_and_drop(web_page_template, not_trash)
        sleep 1
      end.to change{ WebPageTemplate.trash.count }.by(-1)
    end
  end

  describe "Clicking on the trash can brings up a confirmation to empty the trash" do
    before do
      @client, @location, @website = seed
      @website.web_page_templates.first.update_attribute(:in_trash, true)
      visit_website
      within "#trash" do
        click_link "trash-can"
      end
    end

    it "Does nothing if cancel is clicked" do
      expect do
        within ".empty-trash" do
          click_link "empty-trash-cancel"
          sleep 1
        end
      end.not_to change { WebPageTemplate.count }
    end

    it "Empties trash if yes is clicked" do
      expect do
        within ".empty-trash" do
          click_link "empty-trash-yes"
          sleep 1
        end
      end.to change { WebPageTemplate.count }.by(-1)
    end
  end
end
