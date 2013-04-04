require "spec_helper"
require 'remote_stylesheet'

describe RemoteStylesheet do
  before :each do
    @remote_stylesheet = RemoteStylesheet.new("spec/support/remote_stylesheet.scss")
  end
  after :each do
    if File.exists?(@remote_stylesheet.css_file_path)
      FileUtils.rm(@remote_stylesheet.css_file_path)
    end
  end

  describe "#file_name" do
    it "should return the sass file name without .scss" do
      @remote_stylesheet.file_name.should == "remote_stylesheet"
    end
  end
  describe "#scss_file_name" do
    it "should return the file name" do
      @remote_stylesheet.scss_file_name.should == "remote_stylesheet.scss"
    end
  end
  describe "#css_file_name" do
    it "should return the file name with .css" do
      @remote_stylesheet.css_file_name.should == "remote_stylesheet.css"
    end
  end
  describe "#css_dir" do
    it "should include /public/stylesheets" do
      @remote_stylesheet.css_dir.should include "public/stylesheets"
    end
  end
  describe "#css_file_path" do
    it "should include the stylesheet file name" do
      @remote_stylesheet.css_file_path.should include @remote_stylesheet.css_file_name
    end
  end
  describe "#css_link_path" do
    it "should include the styleheet file name" do
      @remote_stylesheet.css_link_path.should include @remote_stylesheet.css_file_name
    end
  end
  describe "#compile_colors" do
    before :each do
      if File.exists?(@remote_stylesheet.colors_path)
        FileUtils.rm(@remote_stylesheet.colors_path)
      end
      @remote_stylesheet.compile_colors
    end
    it "creates colors file" do
      File.exists?(@remote_stylesheet.colors_path).should be_true
    end
  end
  describe "#compile_self" do
    before :each do
      if File.exists?(@remote_stylesheet.css_file_path)
        FileUtils.rm(@remote_stylesheet.css_file_path)
      end
      @remote_stylesheet.compile_colors
      @remote_stylesheet.compile_self
    end
    it "write file to public/stylesheets" do
      File.exists?(@remote_stylesheet.css_file_path).should be_true
    end
  end
  describe "#compile" do
    it "does the right thing" do
      @remote_stylesheet.compile.should == "body {\n  background: black;\n  color: white; }\n"
    end
  end
end
