require "spec_helper"

describe WebLayout do
  before do
    WebLayout.stub(:garden_url) { "spec/support/layouts.html" }
  end
  let(:web_layout) { Fabricate(:web_layout) }
  describe "validations" do
    it "is valid" do
      web_layout.should be_valid
    end
  end

  describe "remote" do
    it "returns six components" do
      WebLayout.all_remote.should have(6).things
    end
  end

  describe "attribute assignment" do
    let(:web_layout) { Fabricate(:web_layout) }

    it { web_layout.name.should eq "Main First Single Column"}
    it { web_layout.stylesheets.should be_empty }
    it { web_layout.html.should match "container single-column" }
    it { web_layout.thumbnail.should eq "http://g5-layout-garden.herokuapp.com/static/components/main-first-single-column/images/thumbnail.png"}
  end

  describe "parse error" do
    it "raises an error if no components are found" do
      # Should be Microformats2::NotFound or something.
      expect { Fabricate(:web_layout, url: "spec/support/blank.html") }.to raise_error StandardError, "No h-g5-component found at url: spec/support/blank.html"
    end
  end

  describe "url not found" do
    it "logs a failed request" do
      Rails.logger.should_receive(:warn).with("404 Object Not Found")
      Fabricate(:web_layout, url: "http://g5-non-existant-app.herokuapp.com")
    end
  end
end
