require "spec_helper"

describe WebTemplatesHelper do
  let(:website) { Fabricate(:website) }
  let(:website_template) { Fabricate(:website_template) }
  let(:web_layout) { Fabricate(:web_layout) }
  let(:web_theme) { Fabricate(:web_theme) }
  let(:web_home_template) { Fabricate(:web_home_template) }
  let(:widget) { Fabricate(:widget) }

  before :each do
    website.website_template = website_template
    website_template.web_layout = web_layout
    website_template.web_theme = web_theme
    website.web_home_template = web_home_template
    web_home_template.widgets << widget
  end

  describe "preview" do
    let(:preview) { helper.preview(website, website.web_page_templates.first) }

    it "has layout in html" do
      preview.should match /single-column/
    end
    it "has widget in html" do
      preview.should match /storage-list widget/
    end
  end
end