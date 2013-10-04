require "spec_helper"

describe StaticWebsite::Deployer do
  let(:website) { Fabricate(:website).decorate }
  let(:subject) { StaticWebsite::Deployer.new(website) }

  describe "#deploy" do
    it "asks the deployer website" do
      subject.deployer.stub(:deploy)
      subject.deployer.should_receive(:deploy).with(subject.deployer_options).once
      subject.deploy
    end
  end

  describe "#deployer" do
    it "is a github heroku deployer obejct" do
      expect(subject.deployer).to be GithubHerokuDeployer
    end
  end

  describe "#deployer_options" do
    it "sets github_repo" do
      expect(subject.deployer_options).to include(github_repo: website.github_repo)
    end

    it "sets heroku_app_name" do
      expect(subject.deployer_options).to include(heroku_app_name: website.heroku_app_name)
    end

    it "sets heroku_repo" do
      expect(subject.deployer_options).to include(heroku_repo: website.heroku_repo)
    end
  end
end
