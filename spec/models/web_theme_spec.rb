require 'spec_helper'

describe WebTheme do
  before do
    WebTheme.stub(:garden_url) { "spec/support/theme-garden.html" }
    WebTheme.any_instance.stub(:url) { "spec/support/web_theme.html" }
  end
  let(:remote_web_themes) { WebTheme.all_remote }
  let(:web_theme) { remote_web_themes.first }

  describe "Remote" do
    it "reads the HTML feed" do
      remote_web_themes.should have(3).things
    end
  end

  describe "attribute assignment" do
    it { web_theme.name.should eq "Classic" }
    it { web_theme.read_attribute(:url).should eq "http://g5-theme-garden.herokuapp.com/components/classic" }
    it { web_theme.thumbnail.should eq "http://g5-theme-garden.herokuapp.com/static/components/classic/images/thumbnail.png"}
  end


  describe "attributes assignment on save" do
    before { web_theme.save! }
    it { web_theme.primary_color.should eq "#0095a0"}
    it { web_theme.secondary_color.should eq "#f68e56"}
    it { web_theme.stylesheets.should eq ["http://g5-theme-garden.herokuapp.com/static/components/classic/stylesheets/classic.scss"]}
    it { web_theme.javascripts.should be_empty }
  end

  describe "errors" do

    it "raises an error if no themes can be found" do
      web_theme.stub(:url) { "spec/support/blank.html" }
      # Should be Microformats2::NotFound or something.
      expect { web_theme.save! }.to raise_error StandardError, "No h-g5-component found at url: #{web_theme.url}"
    end

    it "should rescue from not found" do
      web_theme.stub(:url) { "http://g5-non-existant-app.herokuapp.com" }
      Rails.logger.should_receive(:warn).with("404 Object Not Found")
      web_theme.save!
    end
  end

end
