require 'spec_helper'

describe WebsiteTemplate do
  let(:website_template) { Fabricate.build(:website_template) }

  its(:type) { should eq "WebsiteTemplate" }

  describe "#stylesheets" do
    it "has a collection of stylesheets" do
      website_template.stylesheets.should be_kind_of(Array)
    end
  end

  describe "#javascripts" do
    it "has a collection of javascripts" do
      website_template.javascripts.should be_kind_of(Array)
    end
  end

  describe "#colors" do
    let (:web_theme) { Fabricate.build(:web_theme) }

    before do
      website_template.web_theme = web_theme
      web_theme.stub(:display_colors) { "display colors!" }
    end

    it "asks web_theme for display_colors" do
      web_theme.should_receive(:display_colors).exactly(2).times
      expect(website_template.colors).to eq(web_theme.display_colors)
    end
  end
end
