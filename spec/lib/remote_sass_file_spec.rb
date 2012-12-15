require "spec_helper"
require 'remote_sass_file'

describe RemoteSassFile do
  before :each do
    @remote_sass_file = RemoteSassFile.new("spec/support/remote_sass_file.scss",
      primary: "#ffffff", secondary: "#000000")
  end
  after :each do
    if File.exists?(@remote_sass_file.compiled_file_path)
      FileUtils.rm(@remote_sass_file.compiled_file_path) 
    end
  end

  describe "#file_name" do
    it "should return the sass file name without .scss" do
      @remote_sass_file.file_name.should == "remote_sass_file"
    end
  end
  describe "#sass_file_name" do
    it "should return the file name" do
      @remote_sass_file.sass_file_name.should == "remote_sass_file.scss"
    end
  end
  describe "#css_file_name" do
    it "should return the file name with .css" do
      @remote_sass_file.css_file_name.should == "remote_sass_file.css"
    end
  end
  describe "#compile_path" do
    it "should include /public/stylesheets" do
      @remote_sass_file.compile_path.should include "public/stylesheets"
    end
  end
  describe "#compiled_file_path" do
    it "should include the stylesheet file name" do
      @remote_sass_file.compiled_file_path.should include @remote_sass_file.css_file_name
    end
  end
  describe "#stylesheet_link_path" do
    it "should include the styleheet file name" do
      @remote_sass_file.stylesheet_link_path.should include @remote_sass_file.css_file_name
    end
  end
  describe "#save_locally" do
    before :each do
      if File.exists?(@remote_sass_file.local_path)
        FileUtils.rm(@remote_sass_file.local_path)
      end
      @remote_sass_file.save_locally
    end
    it "saves sass file locally" do
      File.exists?(@remote_sass_file.local_path).should be_true
    end
  end
  describe "#save_colors" do
    before :each do
      if File.exists?(@remote_sass_file.colors_path)
        FileUtils.rm(@remote_sass_file.colors_path)
      end
      @remote_sass_file.save_colors
    end
    it "creates colors file" do
      File.exists?(@remote_sass_file.colors_path).should be_true
    end
  end
  describe "#sass_compile_file" do
    before :each do
      if File.exists?(@remote_sass_file.compiled_file_path)
        FileUtils.rm(@remote_sass_file.compiled_file_path)
      end
      @remote_sass_file.sass_compile_file
    end
    it "write file to public/stylesheets" do
      File.exists?(@remote_sass_file.compiled_file_path).should be_true
    end
  end
  describe "#compile" do
    it "does the right thing" do
      @remote_sass_file.compile.should == "body {\n  background: white;\n  color: black; }\n"
    end
  end
end
