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
end
