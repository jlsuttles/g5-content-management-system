require 'spec_helper'

describe WebTemplate do
  describe "validations" do
    it "has a valid factory" do
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

  describe "#remote_widgets" do
    before do
      Widget.stub(:all_remote).and_return(
        [Fabricate.build(:widget), Fabricate.build(:widget)]
      )
    end

    let(:web_template) { Fabricate.build(:web_template) }
    let(:remotes) { Widget.all_remote }

    it "returns all widgets when web_template has none" do
      web_template.widgets = []
      web_template.remote_widgets.should eq remotes
    end
    it "does not return widgets when web_template already has them" do
      web_template.widgets << remotes.first
      web_template.remote_widgets.should_not include web_template.widgets.last
    end
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
    let(:web_template) { Fabricate.build(:web_template) }
    it "includes slug" do
      web_template.compile_path.should include web_template.slug
    end
  end
  describe "#compiled_stylesheets" do
    let(:web_template) { Fabricate.build(:web_template) }
    it "has a collection of compiled stylesheets" do
      web_template.compiled_stylesheets.should be_kind_of(Array)
    end
  end
end
