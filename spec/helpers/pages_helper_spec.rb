require "spec_helper"

describe PagesHelper do
  let(:location)    { Fabricate(:location) }
  let(:web_layout) { Fabricate(:web_layout) }
  before do
    location.site_template.stub(:web_layout) { web_layout }
    Page.any_instance.stub(:widgets) { [Fabricate(:widget, section: "aside")]}
  end

  describe "preview" do
    it "has layout in html" do
      helper.preview(location, location.pages.first).should match /single-column/
    end

    it "has widget in html" do
      helper.preview(location, location.pages.first).should match /storage-list widget/
    end
  end

end
