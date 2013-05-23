require 'spec_helper'

describe WebsiteTemplate do
  let(:website_template) { Fabricate.build(:website_template) }

  its(:sections) { should eq %w(drop-target-logo drop-target-phone drop-target-btn drop-target-nav drop-target-aside drop-target-footer) }
  its(:type) { should eq "WebsiteTemplate" }
  its(:logo_widgets) { should eq [] }
  its(:phone_widgets) { should eq [] }
  its(:btn_widgets) { should eq [] }
  its(:nav_widgets) { should eq [] }
  its(:aside_widgets) { should eq [] }
  its(:footer_widgets) { should eq [] }

  describe "#stylesheets" do
    let(:website_template) { Fabricate.build(:website_template) }
    it "has a collection of stylesheets" do
      website_template.stylesheets.should be_kind_of(Array)
    end
  end
  describe "#edit_javascript" do
    let(:website_template) { Fabricate.build(:website_template) }
    it "has an edit javascript" do
      website_template.edit_javascript.should be_kind_of(String)
    end
  end
  describe "#show_javascript" do
    let(:website_template) { Fabricate.build(:website_template) }
    it "has a show javascript" do
      website_template.show_javascript.should be_kind_of(String)
    end
  end
    end
  end
end
