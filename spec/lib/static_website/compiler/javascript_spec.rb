require "spec_helper"

describe StaticWebsite::Compiler::Javascript do
  let(:javascript_compiler) { StaticWebsite::Compiler::Javascript }
  let(:javascript_path) { "http://codeorigin.jquery.com/jquery-2.0.3.min.js" }
  let(:compile_path) { File.join(Rails.root, "tmp", "spec", "javascripts") }
  let(:subject) { javascript_compiler.new(javascript_path, compile_path) }

  describe "#compile" do
    before do
      subject.compile_directory.stub(:compile)
      subject.remote_javascript.stub(:compile)
      subject.coffee_javascript.stub(:compile)
    end

    it "compiles compile directory" do
      subject.compile_directory.should_receive(:compile).once
      subject.compile
    end

    it "compiles remote javascript" do
      subject.remote_javascript.should_receive(:compile).once
      subject.compile
    end

    # it "compiles coffee javascript" do
    #   subject.coffee_javascript.should_receive(:compile).once
    #   subject.compile
    # end
  end

  describe "#compile_directory" do
    it "is a compile directory object" do
      expect(subject.compile_directory).to be_a StaticWebsite::Compiler::CompileDirectory
    end
  end

  describe "#remote_javascript" do
    it "is a remote javascript object" do
      expect(subject.remote_javascript).to be_a StaticWebsite::Compiler::RemoteFile
    end
  end

  describe "#coffee_javascript" do
    it "is a coffee javascript object" do
      expect(subject.coffee_javascript).to be_a StaticWebsite::Compiler::Javascript::Coffee
    end
  end
end
