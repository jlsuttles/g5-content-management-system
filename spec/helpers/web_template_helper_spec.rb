require "spec_helper"

describe WebTemplatesHelper do
  let(:location) { Fabricate.build(:location_with_website_with_everything) }

  describe "preview" do
    it "has layout in html" do
      helper.preview(location, location.web_page_templates.first).should match /single-column/
    end

    it "has widget in html" do
      helper.preview(location, location.web_page_templates.first).should match /storage-list widget/
    end
  end

end
