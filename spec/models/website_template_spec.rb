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
end
