require "spec_helper"

describe PageLayout do
  before do
    PageLayout.stub(:garden_url) { "spec/support/layouts.html" }
  end
  let(:page_layout) { Fabricate(:page_layout) }
  describe "validations" do
    it "is valid" do
      page_layout.should be_valid
    end
  end

  describe "remote" do
    it "returns six components" do
      PageLayout.all_remote.should have(6).things
    end
  end

  describe "attribute assignment" do
    let(:page_layout) { Fabricate(:page_layout) }

    it { page_layout.name.should eq "Main First Single Column"}
    it { page_layout.stylesheets.should be_empty }
    it { page_layout.html.should match "container single-column" }
    it { page_layout.thumbnail.should eq "http://g5-layout-garden.herokuapp.com/static/components/main-first-single-column/images/thumbnail.png"}
  end

  describe "parse error" do
    it "raises an error if no components are found" do
      # Should be Microformats2::NotFound or something.
      expect { Fabricate(:page_layout, url: "spec/support/blank.html") }.to raise_error StandardError, "No h-g5-component found at url: spec/support/blank.html"
    end
  end

  describe "url not found" do
    it "logs a failed request" do
      Rails.logger.should_receive(:warn).with("404 Object Not Found")
      Fabricate(:page_layout, url: "http://g5-non-existant-app.herokuapp.com")
    end
  end
end
