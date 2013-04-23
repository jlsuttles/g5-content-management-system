require 'spec_helper'

describe WebsiteDeployer do
  let(:website) { Fabricate(:website) }
  let(:website_template) { Fabricate(:website_template) }
  let(:web_layout) { Fabricate(:web_layout) }
  let(:web_theme) { Fabricate(:web_theme) }
  let(:web_home_template) { Fabricate(:web_home_template) }
  let(:web_page_template) { Fabricate(:web_page_template) }

  before :each do
    Website.stub(:find_by_urn).and_return(website)
    GithubHerokuDeployer.stub(:deploy) { true }
    Website.any_instance.stub(:stylesheets).and_return(["spec/support/remote_stylesheet.scss"])
    WebsiteTemplate.any_instance.stub(:stylesheets).and_return(["spec/support/remote_stylesheet.scss"])
    RemoteJavascript.any_instance.stub(:compile) { true }

    website.website_template = website_template
    website_template.web_layout = web_layout
    website_template.web_theme = web_theme
    website.web_home_template = web_home_template
    website.web_page_templates << web_page_template

    @website_deployer = WebsiteDeployer.new(website.urn)
  end

  describe "perform" do
    it "compiles and deploys" do
      compile_count = 0
      WebsiteDeployer.any_instance.stub(:compile_and_deploy) { compile_count += 1 }
      WebsiteDeployer.perform(website.urn)
      compile_count.should eq 1
    end
  end
  describe "#initialize" do
    it "finds a website" do
      Website.should_receive(:find_by_urn).with(website.urn).once
      WebsiteDeployer.new(website.urn)
    end
  end
  describe "#compile_and_deploy" do
    it "compiles pages" do
      @website_deployer.should_receive(:compile_pages).once
      @website_deployer.compile_and_deploy
    end
    it "compiles stylesheets" do
      @website_deployer.should_receive(:compile_stylesheets).once
      @website_deployer.compile_and_deploy
    end
    it "deploys" do
      @website_deployer.should_receive(:deploy).once
      @website_deployer.compile_and_deploy
    end
    it "creates entries for widgets" do
      @website_deployer.should_receive(:create_entries_for_widget_forms).once
      @website_deployer.compile_and_deploy
    end
    it "cleans up" do
      @website_deployer.should_receive(:remove_compiled_site).once
      @website_deployer.compile_and_deploy
    end
  end
  describe "#compile_pages" do
    it "creates root directory" do
      @website_deployer.compile_pages
      Dir.exists?(website.compile_path).should be_true
    end
    it "compiles all enabled pages" do
      pages = website.web_page_templates.enabled.length + 1 # homepage
      @website_deployer.should_receive(:compile_page).exactly(pages).times
      @website_deployer.compile_pages
    end
  end
  describe "#compile_page" do
    before :each do
      @page = website.web_page_templates.first
      @page_path = @page.compile_path
      FileUtils.rm(@page_path) if File.exists?(@page_path)
      FileUtils.mkdir_p(website.compile_path)
      @website_deployer.compile_page(@page, @page_path)
    end
    it "creates page file" do
      File.exists?(@page_path).should be_true
    end
  end
  describe "#compile_stylesheets" do
    it "creates stylesheets direcoty" do
      @website_deployer.compile_stylesheets
      stylesheets_path = File.join(website.compile_path, "stylesheets")
      Dir.exists?(stylesheets_path).should be_true
    end
    it "compiles all stylesheet" do
      stylesheets = website.stylesheets.length
      @website_deployer.should_receive(:compile_stylesheet).exactly(stylesheets).times
      @website_deployer.compile_stylesheets
    end
  end
  describe "#compile_stylesheet" do
    it "compiles remote sass file" do
      stylesheet = website.stylesheets.first
      stylesheet_path = @website_deployer.stylesheet_path(stylesheet)
      @website_deployer.compile_stylesheet(stylesheet).should == "body {\n  background: black;\n  color: white; }\n"
    end
  end
  describe "#compile_javascripts" do
    it "creates stylesheets direcoty" do
      @website_deployer.compile_javascripts
      javascripts_path = File.join(website.compile_path, "javascripts")
      Dir.exists?(javascripts_path).should be_true
    end
  end
  describe "javascript paths" do
    it "has a javascript path" do
      @website_deployer.javascripts_path.should match "/tmp/compiled_sites/#{website.urn}/javascripts"
    end
    it "has a path to a javascript file" do
      @website_deployer.javascript_path("some-file/script.js").should match "/tmp/compiled_sites/#{website.urn}/javascripts/script.js"
    end
  end
end
