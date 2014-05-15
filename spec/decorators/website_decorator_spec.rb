require 'spec_helper'

describe WebsiteDecorator do
  let!(:client) { Fabricate(:client) }
  let!(:location) { Fabricate(:location) }
  let(:website) { WebsiteDecorator.decorate(Fabricate(:website, owner: location)) }
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
    website.heroku_repo.should match /git@heroku\.com:g5-clw-(\d|\w){7,8}-/
  end

  describe "#heroku_url" do
    it "has a heroku url" do
      website.heroku_url.should match /http:\/\/g5-clw-(\d|\w){7,8}-/
    end

    context "single domain client" do
      let!(:client) { Fabricate(:client, type: "SingleDomainClient") }

      subject { website.heroku_url }

      before do
        Client.stub(first: client)
        client.stub(website: website)
      end

      it { should eq("http://#{website.heroku_app_name}.herokuapp.com/" \
                     "#{website.single_domain_location_path}") }

      context "corporate website" do
        let!(:location) { Fabricate(:location, corporate: true) }

        it { should eq("http://#{website.heroku_app_name}.herokuapp.com") }
      end
    end
  end
end
