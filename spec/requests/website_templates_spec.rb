require "spec_helper"

describe "website_templates requests", js: true do
  before do
    @client = Fabricate(:client)
    @location = Fabricate(:location)
    @website = @location.website
  end

  describe "#edit" do
    before do
      visit edit_website_website_template_path(@website, @website.website_template)
    end
    it "should have content" do
      page.should have_content "Select a Layout".upcase
      page.should have_content "Select a Theme".upcase
      page.should have_content "Theme Colors".upcase
      page.should have_content "Select Widgets".upcase
    end
    it "saves layout" do
      WebLayout.any_instance.stub(:assign_attributes_from_url)
      page.should_not have_css("input:checked[value*=main-first-sidebar-left]")
      find("label[for*=main-first-sidebar-left]").click
      click_button "Submit"
      current_path.should eq website_path(@website)
      visit edit_website_website_template_path(@website, @website.website_template)
      page.should have_css("input:checked[value*=main-first-sidebar-left]")
    end
    it "saves theme" do
      WebTheme.any_instance.stub(:assign_attributes_from_url)
      page.should_not have_css("input:checked[value*=big-picture]")
      find("label[for*=big-picture]").click
      click_button "Submit"
      current_path.should eq website_path(@website)
      visit edit_website_website_template_path(@website, @website.website_template)
      page.should have_css("input:checked[value*=big-picture]")
    end
    it "saves custom colors" do
      page.should_not have_css("input:checked[name*=custom_colors]")
      find("label[for*=custom_colors]").click
      click_button "Submit"
      current_path.should eq website_path(@website)
      visit edit_website_website_template_path(@website, @website.website_template)
      page.should have_css("input:checked[name*=custom_colors]")
    end
    it "saves widgets and their properties" do
      Widget.any_instance.stub(:url) { "spec/support/twitter-feed.html" }
      Widget.any_instance.stub(:get_edit_form_html) {
        open("spec/support/twitter-feed-edit.html").read
      }
      Widget.any_instance.stub(:get_show_html)
      page.should_not have_css(".add-widgets[data-section=header] .twitter-feed")
      source = find("#choose-widgets .twitter-feed")
      target = find(".add-widgets[data-section=header]")
      drag_and_drop(source, target) # native drag_to was not working
      page.should have_css("#modal input[type=text]")
      page.should have_css(".add-widgets[data-section=header] .twitter-feed")
      # shouldn't have to do this twice
      find("#modal").first("input[type=text]").set("jlsuttles")
      find("#modal").first("input[type=text]").set("jlsuttles")
      click_button "Save"
      click_button "Submit"
      current_path.should eq website_path(@website)
      visit edit_website_website_template_path(@website, @website.website_template)
      find(".add-widgets[data-section=header] .twitter-feed").click
      page.should have_css("#modal")
      find("#modal").first("input[type=text]").value.should == "jlsuttles"
    end
  end
end
