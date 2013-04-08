require 'spec_helper'

describe LocationDeployer do
  let(:location) { Fabricate(:location) }
  let(:website) { Fabricate(:website) }
  let(:website_template) { Fabricate(:website_template) }
  let(:web_layout) { Fabricate(:web_layout) }
  let(:web_theme) { Fabricate(:web_theme) }
  let(:web_home_template) { Fabricate(:web_home_template) }
  let(:web_page_template) { Fabricate(:web_page_template) }

  before :each do
    Widget.any_instance.stub(:assign_attributes_from_url) { true }
    WebLayout.any_instance.stub(:assign_attributes_from_url)
    WebsiteTemplate.any_instance.stub(:compiled_stylesheets) { [Faker::Internet.domain_name] }
    WebsiteTemplate.any_instance.stub(:javascripts) { [Faker::Internet.domain_name] }
    GithubHerokuDeployer.stub(:deploy) { true }
    Website.any_instance.stub(:stylesheets).and_return(["spec/support/remote_stylesheet.scss"])
    WebsiteTemplate.any_instance.stub(:stylesheets).and_return(["spec/support/remote_stylesheet.scss"])
    Location.stub(:find_by_urn).with(location.urn) { location }
    RemoteJavascript.any_instance.stub(:compile) { true }

    location.website = website
    website.website_template = website_template
    website_template.web_layout = web_layout
    website_template.web_theme = web_theme
    website.web_home_template = web_home_template
    website.web_page_templates << web_page_template

    @location_deployer = LocationDeployer.new(location.urn)
  end

  describe "perform" do
    it "compiles and deploys" do
      compile_count = 0
      LocationDeployer.any_instance.stub(:compile_and_deploy) { compile_count += 1 }
      LocationDeployer.perform(location.urn)
      compile_count.should eq 1
    end
  end
  describe "#initialize" do
    it "finds a location" do
      Location.should_receive(:find_by_urn).with(location.urn).once
      LocationDeployer.new(location.urn)
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
    it "creates entries for widgets" do
      @location_deployer.should_receive(:create_entries_for_widget_forms).once
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
      Dir.exists?(location.website.compile_path).should be_true
    end
    it "compiles all enabled pages" do
      pages = location.web_page_templates.length + 1 # for homepage
      @location_deployer.should_receive(:compile_page).exactly(pages).times
      @location_deployer.compile_pages
    end
    it "skips compiling of disabled pages" do
      @location.pages.first.update_attribute(:disabled, true)
      pages = @location.pages.length
      @location_deployer.should_receive(:compile_page).exactly(pages).times
      @location_deployer.compile_pages
    end
  end
  describe "#compile_page" do
    before :each do
      @page = location.web_page_templates.first
      @page_path = @page.compile_path
      FileUtils.rm(@page_path) if File.exists?(@page_path)
      FileUtils.mkdir_p(location.website.compile_path)
      @location_deployer.compile_page(@page, @page_path)
    end
    it "creates page file" do
      File.exists?(@page_path).should be_true
    end
  end
  describe "#compile_stylesheets" do
    it "creates stylesheets direcoty" do
      @location_deployer.compile_stylesheets
      stylesheets_path = File.join(location.website.compile_path, "stylesheets")
      Dir.exists?(stylesheets_path).should be_true
    end
    it "compiles all stylesheet" do
      stylesheets = location.website.stylesheets.length
      @location_deployer.should_receive(:compile_stylesheet).exactly(stylesheets).times
      @location_deployer.compile_stylesheets
    end
  end
  describe "#compile_stylesheet" do
    it "compiles remote sass file" do
      stylesheet = location.website.stylesheets.first
      stylesheet_path = @location_deployer.stylesheet_path(stylesheet)
      @location_deployer.compile_stylesheet(stylesheet).should == "body {\n  background: black;\n  color: white; }\n"
    end
  end
  describe "#compile_javascripts" do
    it "creates stylesheets direcoty" do
      @location_deployer.compile_javascripts
      javascripts_path = File.join(location.website.compile_path, "javascripts")
      Dir.exists?(javascripts_path).should be_true
    end
  end
  describe "javascript paths" do
    it "has a javascript path" do
      @location_deployer.javascripts_path.should match "/tmp/compiled_sites/#{location.website.urn}/javascripts"
    end
    it "has a path to a javascript file" do
      @location_deployer.javascript_path("some-file/script.js").should match "/tmp/compiled_sites/#{location.website.urn}/javascripts/script.js"
    end
  end
end
