require "spec_helper"

describe WebTemplatesHelper do
  let(:location)    { Fabricate(:location) }
  let(:web_layout) { Fabricate(:web_layout) }
  before do
    location.website_template.stub(:web_layout) { web_layout }
    WebTemplate.any_instance.stub(:widgets) { [Fabricate(:widget, section: "aside")]}
  end

  describe "preview" do
    it "has layout in html" do
      helper.preview(location, location.web_templates.first).should match /single-column/
    end

    it "has widget in html" do
      helper.preview(location, location.web_page_templates.first).should match /storage-list widget/
    end
  end

end
