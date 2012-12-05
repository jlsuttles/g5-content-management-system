require 'spec_helper'

describe LocationDeployer do
  before {
    PageLayout.any_instance.stub(:assign_attributes_from_url)
    SiteTemplate.any_instance.stub(:stylesheets) { [Faker::Internet.domain_name] }
    GithubHerokuDeployer.stub(:deploy) { true }
    
    @location = Fabricate(:location)
    @location.site_template.layout = Fabricate(:page_layout)
    Location.stub(:find).with(@location.id) { @location }
  }
  
  it "should delete the repos dir" do
    @location.should_receive(:delete_repo).once
    LocationDeployer.perform(@location.id)
  end

  it "should delete the compiled dir" do
    @location.should_receive(:delete_compiled_folder).twice
    LocationDeployer.perform(@location.id)
  end

  it "calls deploy" do
    @location.should_receive(:deploy).once
    LocationDeployer.perform(@location.id)
  end

  it "finds a location" do
    Location.should_receive(:find).with(@location.id).once
    LocationDeployer.perform(@location.id)
  end
end