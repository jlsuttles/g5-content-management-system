require 'spec_helper'

describe ReleasesManager do
  let!(:location) { Fabricate(:location) }
  let!(:website) { Fabricate(:website, location: location) }
  let(:releases_manager) { ReleasesManager.new(website_slug, limit) }
  let(:limit) { nil }

  describe "#fetch_all" do
    subject { releases_manager.fetch_all }

    context "a valid location" do
      let(:releases) { open(Rails.root+"spec/support/releases.json").read }
      let(:website_slug) { location.name.parameterize }

      before { HTTParty.stub_chain(:get, :body).and_return(releases) }

      its(:size) { 5 }

      context "custom limit" do
        let(:limit) { 3 }

        its(:size) { 3 }
      end

      context "specific data" do
        subject { releases_manager.fetch_all.first }

        its(["id"]) { should eq("7b4590be-58a6-4e0e-946c-d332ef27f0a5") }
        its(["version"]) { should eq(52) }
        its(["created_at"]) { should eq("2014-01-22T01:12:51Z") }
        its(["description"]) { should eq("Deploy ef4d0d6") }
      end
    end

    context "an in-valid location" do
      let(:website_slug) { nil }

      it { should be_nil }
    end
  end

  describe "#rollback" do
    let(:release_id) { "12-3" }

    subject { releases_manager.rollback(release_id) }

    context "a valid location" do
      let(:website_slug) { location.name.parameterize }
      let(:heroku_client) { double(rollback: nil) }

      before { HerokuClient.stub(new: heroku_client) }

      it "calls rollback on HerokuClient" do
        heroku_client.should_receive(:rollback)
        subject
      end
    end

    context "an in-valid location" do
      let(:website_slug) { nil }

      it { should be_nil }
    end
  end
end
