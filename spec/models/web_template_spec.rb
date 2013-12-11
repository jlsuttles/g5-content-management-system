require 'spec_helper'

describe WebTemplate do
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
    let(:web_template) { Fabricate.build(:web_template) }

    it { web_template.should respond_to :web_layout }
  end

  describe "#web_theme" do
    let(:web_template) { Fabricate.build(:web_template) }

    it { web_template.should respond_to :web_theme }
  end

  describe "#widgets" do
    let(:web_template) { Fabricate.build(:web_template) }

    it { web_template.should respond_to :widgets }
  end

  describe "#stylesheets" do
    let(:web_template) { Fabricate.build(:web_template) }

    it "has a collection of stylesheets" do
      web_template.stylesheets.should be_kind_of(Array)
    end
  end

  describe "#javascripts" do
    let(:web_template) { Fabricate.build(:web_template) }

    it "has a collection of javascripts" do
      web_template.javascripts.should be_kind_of(Array)
    end
  end

  describe "#compile_path" do
    let(:web_template) { Fabricate(:web_template) }
    let!(:client) { Fabricate(:client) }

    it "includes slug" do
      web_template.compile_path.should include web_template.slug
    end
  end

  describe "#stylesheet_link_paths" do
    let(:web_template) { Fabricate.build(:web_template) }

    it "has a collection of stylesheets link paths" do
      web_template.stylesheet_link_paths.should be_kind_of(Array)
    end
  end
end
