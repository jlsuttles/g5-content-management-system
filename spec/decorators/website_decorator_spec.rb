require 'spec_helper'

describe WebsiteDecorator do
  let(:website) { WebsiteDecorator.decorate(Fabricate(:website)) }
  before do
    Website.any_instance.stub(:name).and_return "awesome location name"
  end
  it "has a github repo" do
    website.github_repo.should eq "git@github.com:G5/static-heroku-app.git"
  end
  it "has a 30 character heroku name" do
    website.heroku_app_name.length.should eq 30
  end
  it "has a heroku repo" do
    website.heroku_repo.should match /git@heroku\.com:g5-clw-\d+-/
  end
  it "has a heroku url" do
    website.heroku_url.should match /https:\/\/g5-clw-\d+-/
  end
end
