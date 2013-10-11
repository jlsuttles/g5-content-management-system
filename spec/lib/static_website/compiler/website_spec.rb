require "spec_helper"

describe StaticWebsite::Compiler::Website do
  let(:website) { Fabricate(:website) }

  describe "#compile" do
    let(:subject) { StaticWebsite::Compiler::Website.new(website) }

    it "compiles compile directory" do
      subject.compile_directory.should_receive(:compile).once
      subject.compile
    end

    it "compiles javascripts" do
      subject.javascripts.should_receive(:compile).once
      subject.compile
    end

    it "compiles stylesheets" do
      subject.stylesheets.should_receive(:compile).once
      subject.compile
    end

    it "compiles web home template" do
      subject.web_home_template.should_receive(:compile).once
      subject.compile
    end

    it "compiles web page templates" do
      subject.compile_directory.should_receive(:compile).once
      subject.compile
    end
  end

  describe "#compile_directory" do
    let(:subject) { StaticWebsite::Compiler::Website.new(website) }

    it "is a compile directory object" do
      expect(subject.compile_directory).to be_a StaticWebsite::Compiler::CompileDirectory
    end
  end

  describe "#javascripts" do
    let(:subject) { StaticWebsite::Compiler::Website.new(website) }

    it "is a javascripts object" do
      expect(subject.javascripts).to be_a StaticWebsite::Compiler::Javascripts
    end
  end

  describe "#stylesheets" do
    let(:subject) { StaticWebsite::Compiler::Website.new(website) }

    it "is a stylesheets object" do
      expect(subject.stylesheets).to be_a StaticWebsite::Compiler::Stylesheets
    end
  end

  describe "#web_home_template" do
    let(:subject) { StaticWebsite::Compiler::Website.new(website) }

    it "is a web template object" do
      expect(subject.web_home_template).to be_a StaticWebsite::Compiler::WebTemplate
    end
  end

  describe "#web_page_templates" do
    let(:subject) { StaticWebsite::Compiler::Website.new(website) }

    it "is a web templates object" do
      expect(subject.web_page_templates).to be_a StaticWebsite::Compiler::WebTemplates
    end
  end
end
