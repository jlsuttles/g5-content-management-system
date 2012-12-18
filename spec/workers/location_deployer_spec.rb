require 'spec_helper'

describe LocationDeployer do
  before :each do
    PageLayout.any_instance.stub(:assign_attributes_from_url)
    SiteTemplate.any_instance.stub(:compiled_stylesheets) { [Faker::Internet.domain_name] }
    SiteTemplate.any_instance.stub(:javascripts) { [Faker::Internet.domain_name] }
    GithubHerokuDeployer.stub(:deploy) { true }

    @location = Fabricate(:location)
    @location.site_template = Fabricate(:site_template)
    @location.stub(:all_stylesheets).and_return(["spec/support/remote_stylesheet.scss"])
    
    @location.stub(:homepage) { @location.pages.first }
    Location.stub(:find_by_urn).with(@location.urn) { @location }
    @location_deployer = LocationDeployer.new(@location.urn)
  end

  describe "#initialize" do
    it "finds a location" do
      Location.should_receive(:find_by_urn).with(@location.urn).once
      LocationDeployer.new(@location.urn)
    end
  end
  describe "#compile_and_deploy" do
    it "compiles pages" do
      @location_deployer.should_receive(:compile_pages).once
      @location_deployer.compile_and_deploy
    end
    it "compiles stylesheets" do
      @location_deployer.should_receive(:compile_stylesheets).once
      @location_deployer.compile_and_deploy
    end
    it "deploys" do
      @location_deployer.should_receive(:deploy).once
      @location_deployer.compile_and_deploy
    end
    it "cleans up" do
      @location_deployer.should_receive(:remove_compiled_site).once
      @location_deployer.compile_and_deploy
    end
  end
  describe "#compile_pages" do
    it "creates root directory" do
      @location_deployer.compile_pages
      Dir.exists?(@location.compiled_site_path).should be_true
    end
    it "compiles all pages" do
      pages = @location.pages.length + 1 # for homepage
      @location_deployer.should_receive(:compile_page).exactly(pages).times
      @location_deployer.compile_pages
    end
  end
  describe "#compile_page" do
    before :each do
      @page = @location.pages.first
      @page_path = @page.compiled_file_path
      FileUtils.rm(@page_path) if File.exists?(@page_path)
      FileUtils.mkdir_p(@location.compiled_site_path)
      @location_deployer.compile_page(@page, @page_path)
    end
    it "creates page file" do
      File.exists?(@page_path).should be_true
    end
  end
  describe "#compile_stylesheets" do
    it "creates stylesheets direcoty" do
      @location_deployer.compile_stylesheets
      stylesheets_path = File.join(@location.compiled_site_path, "stylesheets")
      Dir.exists?(stylesheets_path).should be_true
    end
    it "compiles all stylesheet" do
      stylesheets = @location.all_stylesheets.length
      @location_deployer.should_receive(:compile_stylesheet).exactly(stylesheets).times
      @location_deployer.compile_stylesheets
    end
  end
  describe "#compile_stylesheet" do
    it "compiles remote sass file" do
      stylesheet = @location.all_stylesheets.first
      stylesheet_path = @location_deployer.stylesheet_path(stylesheet)
      @location_deployer.compile_stylesheet(stylesheet).should == "body {\n  background: black;\n  color: white; }\n"
    end
  end
end
