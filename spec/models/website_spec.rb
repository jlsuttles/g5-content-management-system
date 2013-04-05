require 'spec_helper'

describe Website do
  describe ".urn_prefix" do
    it "is g5-clw" do
      Website.urn_prefix.should eq "g5-clw"
    end
  end
  describe "validations" do
    it "should have a valid fabricator" do
      Fabricate.build(:website).should be_valid
    end
    it "should require urn" do
      Fabricate.build(:website, urn: "").should_not be_valid
    end
  end
  describe "#urn" do
    let(:website) { Fabricate(:website) }
    it "sets on save" do
      website.urn.should match /g5-clw-1-/
    end
  end
  describe "#to_param" do
    let(:website) { Fabricate(:website) }
    it "uses urn" do
      website.to_param.should eq website.urn
    end
  end
  describe "#web_templates" do
    let(:website) { Fabricate(:website) }
    it "creates two on create" do
      expect { website }.to change(WebTemplate, :count).by(2)
    end
    it "includes website_template" do
      website.web_templates.should include website.website_template
    end
    it "includes web_home_template" do
      website.web_templates.should include website.web_home_template
    end
  end
  describe "#website_template" do
    let(:website) { Fabricate(:website) }
    it "creates one on create" do
      expect { website }.to change(WebsiteTemplate, :count).by(1)
    end
    it "is a website template" do
      website.website_template.should be_kind_of(WebsiteTemplate)
    end
  end
  describe "#web_home_template" do
    let(:website) { Fabricate(:website) }
    it "creates one" do
      expect { website }.to change(WebHomeTemplate, :count).by(1)
    end
    it "is a web page template" do
      website.web_home_template.should be_kind_of(WebHomeTemplate)
    end
  end
  describe "#name" do
    let(:website) { Fabricate.build(:website_with_location) }
    let(:location) { website.location }
    it "uses location's name" do
      website.name.should eq location.name
    end
  end
  describe "#compile_path" do
    let(:website) { Fabricate(:website) }
    it "includes urn" do
      website.compile_path.should include website.urn
    end
  end
  describe "#stylesheets" do
    let(:website) { Fabricate(:website) }
    it "has a collection of stylesheets" do
      website.stylesheets.should be_kind_of(Array)
    end
  end
  describe "#javascripts" do
    let(:website) { Fabricate(:website) }
    it "has a collection of javascripts" do
      website.javascripts.should be_kind_of(Array)
    end
  end
  describe "#deploy" do
    let(:website) { Fabricate(:website) }
    it "calls LocationDeployer with urn" do
      LocationDeployer.should_receive(:perform).with(website.urn).once
      website.deploy
    end
  end
  describe "#async_deploy" do
    let(:website) { Fabricate(:website) }
    it "enquques LocationDeployer with urn" do
      Resque.stub(:enqueue)
      Resque.should_receive(:enqueue).with(LocationDeployer, website.urn).once
      website.async_deploy
    end
  end
end
