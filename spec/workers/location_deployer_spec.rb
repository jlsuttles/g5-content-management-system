require 'spec_helper'

describe LocationDeployer do
  before {
    PageLayout.any_instance.stub(:assign_attributes_from_url)
    SiteTemplate.any_instance.stub(:compiled_stylesheets) { [Faker::Internet.domain_name] }
    SiteTemplate.any_instance.stub(:javascripts) { [Faker::Internet.domain_name] }
    GithubHerokuDeployer.stub(:deploy) { true }

    @location = Fabricate(:location)
    @location.site_template = Fabricate(:site_template)
    
    @location.stub(:homepage) { @location.pages.first }
    Location.stub(:find_by_urn).with(@location.urn) { @location }
  }

  it "should delete the repos dir" do
    @location.should_receive(:delete_repo).once
    LocationDeployer.perform(@location.urn)
  end

  it "should delete the compiled dir" do
    @location.should_receive(:delete_compiled_folder).twice
    LocationDeployer.perform(@location.urn)
  end

  it "calls deploy" do
    @location.should_receive(:deploy).once
    LocationDeployer.perform(@location.urn)
  end

  it "finds a location" do
    Location.should_receive(:find_by_urn).with(@location.urn).once
    LocationDeployer.perform(@location.urn)
  end
end
