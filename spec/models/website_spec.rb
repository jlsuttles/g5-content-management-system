require "spec_helper"

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

    it "should not require urn on new records" do
      Fabricate.build(:website, urn: "").should be_valid
    end

    it "should require urn on old records" do
      website = Fabricate(:website)
      website.urn = ""
      website.should_not be_valid
    end
  end

  describe "#urn" do
    let(:website) { Fabricate(:website) }

    it "sets on create" do
      website.urn.should match /g5-clw-\d+-/
    end
  end

  describe "#website_id" do
    let(:website) { Fabricate(:website) }

    it "returns own id" do
      website.website_id.should eq website.id
    end
  end

  describe "#name" do
    let(:website) { Fabricate.build(:website) }
    let(:location) { Fabricate.build(:location) }

    it "uses location's name" do
      website.location = location
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

    it "calls WebsiteDeployer with urn" do
      WebsiteDeployer.should_receive(:perform).with(website.urn).once
      website.deploy
    end
  end

  describe "#async_deploy" do
    let(:website) { Fabricate(:website) }

    it "enqueues WebsiteDeployer with urn" do
      Resque.stub(:enqueue)
      Resque.should_receive(:enqueue).with(WebsiteDeployer, website.urn).once
      website.async_deploy
    end
  end

  describe "Colors" do
    let(:website) { Fabricate(:website) }

    describe "Default" do
      it { website.primary_color.should eq "#000000" }
      it { website.secondary_color.should eq "#ffffff" }
    end

    describe "Custom" do
      let(:website_template) { Fabricate(:website_template) }
      let(:web_theme) { Fabricate(:web_theme) }

      before do
        website.website_template = website_template
        website.website_template.web_theme = web_theme
        website.stub(:custom_colors?) { true }
        website.stub(:read_attribute) { "#111111" }
      end

      it { website.primary_color.should eq "#111111" }
      it { website.secondary_color.should eq "#111111" }
    end

    describe "Website Template" do
      let(:website_template) { Fabricate(:website_template) }
      let(:web_theme) { Fabricate(:web_theme) }

      before do
        website.website_template = website_template
        website.website_template.web_theme = web_theme
      end

      it { website.primary_color.should eq "#000000" }
      it { website.secondary_color.should eq "#ffffff" }

      it do
        website.website_template.stub(:primary_color) { "#121212"}
        website.primary_color.should eq "#121212"
      end

      it do
        website.website_template.stub(:secondary_color) { "#212121"}
        website.secondary_color.should eq "#212121"
      end
    end
  end
end
