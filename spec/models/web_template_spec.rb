require 'spec_helper'

describe WebTemplate do
  let(:location) { Fabricate.build(:location) }
  let(:website) { Fabricate.build(:website, owner: location) }
  let(:web_template) { Fabricate.build(:web_template, website: website) }

  describe "validations" do
    it "has a valid fabricator" do
      Fabricate.build(:web_template).should be_valid
    end
    it "requires name" do
      Fabricate.build(:web_template, name: "").should be_invalid
    end
    it "require title" do
      Fabricate.build(:web_template, title: "").should be_invalid
    end
    it "does not require slug, because creates from title" do
      Fabricate.build(:web_template, slug: "").should be_valid
    end
  end

  describe "#web_layout" do
    it { web_template.should respond_to :web_layout }
  end

  describe "#web_theme" do
    it { web_template.should respond_to :web_theme }
  end

  describe "#widgets" do
    it { web_template.should respond_to :widgets }
  end

  describe "#stylesheets" do
    it "has a collection of stylesheets" do
      web_template.stylesheets.should be_kind_of(Array)
    end
  end

  describe "#javascripts" do
    it "has a collection of javascripts" do
      web_template.javascripts.should be_kind_of(Array)
    end
  end

  describe "#stylesheet_link_paths" do
    it "has a collection of stylesheets link paths" do
      web_template.stylesheet_link_paths.should be_kind_of(Array)
    end
  end

  describe "#url" do
    let!(:client) { Fabricate(:client, type: type) }
    let(:multi_domain_formatter) { double(format: nil) }
    let(:single_domain_formatter) { double(format: nil) }

    before do
      URLFormat::SingleDomainFormatter.stub(new: single_domain_formatter)
      URLFormat::MultiDomainFormatter.stub(new: multi_domain_formatter)
      web_template.url
    end

    context "single domain client" do
      let(:type) { "SingleDomain"}

      it "calls the correct formatter" do
        expect(single_domain_formatter).to have_received(:format)
      end
    end

    context "multi domain client" do
      let(:type) { "MultiDomain"}

      it "calls the correct formatter" do
        expect(multi_domain_formatter).to have_received(:format)
      end
    end
  end
end
