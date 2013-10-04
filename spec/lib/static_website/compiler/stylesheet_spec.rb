require "spec_helper"

describe StaticWebsite::Compiler::Stylesheet do
  let(:stylesheet_compiler) { StaticWebsite::Compiler::Stylesheet }
  let(:stylesheet_path) { "http://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" }
  let(:compile_path) { File.join(Rails.root, "tmp", "spec", "stylesheets") }
  let(:subject) { stylesheet_compiler.new(stylesheet_path, compile_path) }

  describe "#compile" do
    before do
      subject.compile_directory.stub(:compile)
      subject.remote_stylesheet.stub(:compile)
      subject.scss_stylesheet.stub(:compile)
    end

    it "compiles compile directory" do
      subject.compile_directory.should_receive(:compile).once
      subject.compile
    end

    it "compiles remote stylesheet" do
      subject.remote_stylesheet.should_receive(:compile).once
      subject.compile
    end

    it "compiles scss stylesheet" do
      subject.scss_stylesheet.should_receive(:compile).once
      subject.compile
    end
  end

  describe "#compile_directory" do
    it "is a compile directory object" do
      expect(subject.compile_directory).to be_a StaticWebsite::Compiler::CompileDirectory
    end
  end

  describe "#remote_stylesheet" do
    it "is a remote file object" do
      expect(subject.remote_stylesheet).to be_a StaticWebsite::Compiler::RemoteFile
    end
  end

  describe "#scss_stylesheet" do
    it "is a scss stylesheet object" do
      expect(subject.scss_stylesheet).to be_a StaticWebsite::Compiler::Stylesheet::Scss
    end
  end
end
