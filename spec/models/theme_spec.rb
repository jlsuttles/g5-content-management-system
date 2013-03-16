require 'spec_helper'

describe Theme do
  before do
    stub_const("Theme::THEME_GARDEN_URL", "spec/support/theme-garden.html")
    Theme.any_instance.stub(:url) { "spec/support/theme.html" }
  end
  let(:remote_themes) { Theme.all_remote }
  let(:theme) { remote_themes.first }
  
  describe "Remote" do
    it "reads the HTML feed" do
      remote_themes.should have(3).things
    end
  end
  
  describe "attribute assignment" do
    it { theme.name.should eq "Classic" }
    it { theme.read_attribute(:url).should eq "http://g5-theme-garden.herokuapp.com/components/classic" }
    it { theme.thumbnail.should eq "http://g5-theme-garden.herokuapp.com/static/components/classic/images/thumbnail.png"}
  end
  
  
  describe "attributes assignment on save" do
    before { theme.save! }
    it { theme.primary_color.should eq "#0095a0"}
    it { theme.secondary_color.should eq "#f68e56"}
    it { theme.stylesheets.should eq ["http://g5-theme-garden.herokuapp.com/static/components/classic/stylesheets/classic.scss"]}
    it { theme.javascripts.should be_empty }
  end
  
  describe "errors" do
    
    it "raises an error if no themes can be found" do
      theme.stub(:url) { "spec/support/blank.html" }
      # Should be G5HentryConsumer::NotFound or something.
      expect { theme.save! }.to raise_error StandardError, "No h-g5-component found at url: #{theme.url}"
    end
    
    it "should rescue from not found" do
      theme.stub(:url) { "http://g5-non-existant-app.herokuapp.com" }
      Rails.logger.should_receive(:warn).with("404 Object Not Found")
      theme.save!
    end
  end
  
end
