require 'spec_helper'

describe WebsiteTemplate do
  let(:website_template) { Fabricate.build(:website_template) }

  its(:sections) { should eq ['header', 'aside', 'footer']}
  its(:type) { should eq "WebsiteTemplate" }
  its(:header_widgets) { should eq [] }
  its(:aside_widgets) { should eq [] }
  its(:footer_widgets) { should eq [] }

  describe "#stylesheets" do
    let(:website_template) { Fabricate.build(:website_template) }
    it "has a collection of stylesheets" do
      website_template.stylesheets.should be_kind_of(Array)
    end
  end
  describe "#javascripts" do
    let(:website_template) { Fabricate.build(:website_template) }
    it "has a collection of javascripts" do
      website_template.javascripts.should be_kind_of(Array)
    end
  end

  describe "default header widgets" do
    before do
      WebsiteTemplate.any_instance.unstub(:create_default_header_widgets)
      Widget.stub(build_widget_url: "spec/support/widget.html")
      WebsiteTemplate.any_instance.stub(default_header_widgets: ["storage-list"])
      @website_template = Fabricate(:website_template)
    end
    it "builds default header widgets" do
      @website_template.widgets.map(&:name).should include("Storage List")
    end
    it "assigns the widgets to the 'header' section" do
      @website_template.header_widgets.count.should ==
        @website_template.default_header_widgets.length
    end
  end

  describe "default footer widgets" do
    before do
      WebsiteTemplate.any_instance.unstub(:create_default_footer_widgets)
      Widget.stub(build_widget_url: "spec/support/widget.html")
      WebsiteTemplate.any_instance.stub(default_footer_widgets: ["storage-list"])
      @website_template = Fabricate(:website_template)
    end
    it "builds default footer widgets" do
      @website_template.widgets.map(&:name).should include("Storage List")
    end
    it "assigns the widgets to the 'footer' section" do
      @website_template.footer_widgets.count.should ==
        @website_template.default_footer_widgets.length
    end
  end
end
