require File.dirname(__FILE__) + '/../spec_helper'

describe Location do
  let(:location) { Fabricate(:location) }

  describe "Validations" do
    it "should be valid" do
      Location.new.should be_valid
    end
  end

  describe "Colors" do
    describe "Custom" do
      before { location.stub(:custom_colors?) { true } }
      it { location.primary_color.should eq "#111111" }
      it { location.secondary_color.should eq "#222222" }
    end

    describe "Site Template" do
      it { location.primary_color.should eq "#000000" }
      it { location.secondary_color.should eq "#ffffff" }
      it do
        location.site_template.stub(:primary_color) { "#121212"}
        location.primary_color.should eq "#121212"
      end
      it do
        location.site_template.stub(:secondary_color) { "#212121"}
        location.secondary_color.should eq "#212121"
      end
    end
  end

  describe "Pages" do
    it "adds a page on creation" do
      expect { location }.to change(Page, :count).by(5)
    end

    it "doesn't count template as a page" do
      template = Page.create(location_id: location.id, name: "Template", template: true)
      location.pages.should_not include template
    end

    it "has a template as a page" do
      location.site_template.should_not be_blank
    end

    it "has a homepage" do
      location.homepage.slug.should eq "home"
    end

  end

end

