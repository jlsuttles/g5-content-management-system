require "requests_helper"

describe "site_templates requests", js: true do
  before do
    @client = Fabricate(:client)
    @location = Fabricate(:location)
  end

  describe "#edit" do
    before do
      visit edit_location_site_template_path(@location, @location.site_template)
    end
    it "should have content" do
      page.should have_content "Select a Layout".upcase
      page.should have_content "Select a Theme".upcase
      page.should have_content "Customize Colors".upcase
      page.should have_content "Select Widgets".upcase
    end
    it "saves layout" do
      page.should_not have_css("input:checked[value*=main-first-sidebar-left]")
      find("label[for*=main-first-sidebar-left]").click
      click_button "Submit"
      current_path.should eq location_path(@location)
      visit edit_location_site_template_path(@location, @location.site_template)
      page.should have_css("input:checked[value*=main-first-sidebar-left]")
    end
    it "saves theme" do
      page.should_not have_css("input:checked[value*=big-picture]")
      find("label[for*=big-picture]").click
      click_button "Submit"
      current_path.should eq location_path(@location)
      visit edit_location_site_template_path(@location, @location.site_template)
      page.should have_css("input:checked[value*=big-picture]")
    end
    it "saves custom colors" do
      page.should_not have_css("input:checked[name*=custom_colors]")
      find("label[for*=custom_colors]").click
      click_button "Submit"
      current_path.should eq location_path(@location)
      visit edit_location_site_template_path(@location, @location.site_template)
      page.should have_css("input:checked[name*=custom_colors]")
    end
    it "saves widgets and their properties" do
      page.should_not have_css(".add-widgets[data-section=header] .twitter-feed")
      source = find("#choose-widgets .twitter-feed")
      target = find(".add-widgets[data-section=header]")
      drag_and_drop(source, target) # drag_to was not working
      page.should_not have_content "jlsuttles"
      find("input[type=text][placeholder=username]").set("jlsuttles")
      find("input[type=text][placeholder=username]").set("jlsuttles")
      click_button "Save"
      click_button "Submit"
      current_path.should eq location_path(@location)
      visit edit_location_site_template_path(@location, @location.site_template)
      page.should have_css(".add-widgets[data-section=header] .twitter-feed")
      find(".add-widgets[data-section=header] .twitter-feed").click
      find("input[type=text][placeholder=username]").value.should eq "jlsuttles"
    end
  end
end
