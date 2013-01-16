require 'spec_helper'

describe RemoteJavascript do
  let(:remote_javascript) { RemoteJavascript.new("spec/support/remote_javascript.js") }
  
  after do
    if File.exists?(remote_javascript.js_file_path)
      FileUtils.rm(remote_javascript.js_file_path) 
    end
  end
  
  describe "#js_dir" do
    it "has a default js dir" do
      remote_javascript.js_dir.should eq File.join(Rails.root, "public", "javascripts")
    end
    
    it "assigns a js_dir" do
      remote_javascript = RemoteJavascript.new("spec/support/remote_javascript.js", "/path/to/js")
      remote_javascript.js_dir.should eq "/path/to/js"
    end
  end
  
  describe "#js_file_name" do
    it "assigns and returns the filename" do
      remote_javascript.js_file_name.should eq "remote_javascript.js"
    end
  end
  
  describe "#js_file_path" do
    it "returns the full file path" do
      remote_javascript.js_file_path.should eq File.join(Rails.root, "public", "javascripts") + "/remote_javascript.js"
    end
  end
  
  describe "#js_link_path" do
    it "returns the link path" do
      remote_javascript.js_link_path.should eq "/javascripts/remote_javascript.js"
    end
  end
  
  describe "#compile" do
    it "creates the dir" do
      remote_javascript.compile
      Dir.exists?(remote_javascript.js_dir).should be_true
    end
    
    it "creates compiled js file" do
      remote_javascript.compile
      File.exists?(remote_javascript.js_file_path).should be_true
    end
    
    it "returns the content of the remote file" do
      remote_javascript.compile.should eq "console.log(\"I'm a file!\")"
    end
  end
end