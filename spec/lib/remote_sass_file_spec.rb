require "spec_helper"
require 'remote_sass_file'

describe RemoteSassFile do
  before :each do
    @remote_sass_file = RemoteSassFile.new("spec/support/remote_sass_file.scss")
  end
  after :each do
    if File.exists?(@remote_sass_file.public_sass_file_path)
      FileUtils.rm(@remote_sass_file.public_sass_file_path) 
    end
    if File.exists?(@remote_sass_file.public_css_file_path)
      FileUtils.rm(@remote_sass_file.public_css_file_path) 
    end
  end

  describe "#sass_file_path" do
    it "should return the file path" do
      @remote_sass_file.sass_file_path.should == "spec/support/remote_sass_file.scss"
    end
  end
  describe "#sass_file_name" do
    it "should return the file name" do
      @remote_sass_file.sass_file_name.should == "remote_sass_file.scss"
    end
  end
  describe "#file_name" do
    it "should return the sass file name without .scss" do
      @remote_sass_file.file_name.should == "remote_sass_file"
    end
  end
  describe "#css_file_name" do
    it "should return the file name with .css" do
      @remote_sass_file.css_file_name.should == "remote_sass_file.css"
    end
  end
  describe "#public_css_path" do
    it "should include /public/stylesheets" do
      @remote_sass_file.public_css_file_path.should include "public/stylesheets"
    end
  end
  describe "#public_sass_path" do
    it "should include /public/stylesheets/sass" do
      @remote_sass_file.public_sass_file_path.should include "public/stylesheets/sass"
    end
  end
  describe "#write_to_public_stylesheets_sass" do
    before :each do
      if File.exists?(@remote_sass_file.public_sass_file_path)
        FileUtils.rm(@remote_sass_file.public_sass_file_path)
      end
      @remote_sass_file.write_to_public_stylesheets_sass
    end
    it "write file to public/stylesheets/sass/" do
      File.exists?(@remote_sass_file.public_sass_file_path).should be_true
    end
  end
  describe "#compile_to_public_stylesheets" do
    before :each do
      if File.exists?(@remote_sass_file.public_css_file_path)
        FileUtils.rm(@remote_sass_file.public_css_file_path)
      end
      @remote_sass_file.compile_to_public_stylesheets
    end
    it "write file to public/stylesheets" do
      File.exists?(@remote_sass_file.public_css_file_path).should be_true
    end
  end
end
