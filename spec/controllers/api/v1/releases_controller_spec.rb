require "spec_helper"

describe Api::V1::ReleasesController do
  let(:release_manager) { double(fetch_all: nil, rollback: nil) }

  before { ReleasesManager.stub(new: release_manager) }

  describe "#index" do
    it "calls releases on ReleasesManager" do
      release_manager.should_receive(:fetch_all)
      get :index, website_slug: "foo"
    end
  end

  describe "#rollback" do
    it "calls rollback on ReleasesManager" do
      release_manager.should_receive(:rollback).with("123")
      post :rollback, website_slug: "foo", release_id: "123"
    end
  end
end
