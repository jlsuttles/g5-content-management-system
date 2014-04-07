require "spec_helper"

describe Api::V1::ReleasesController do
  let(:releases) { [{ version: 10 }, { version: 11 }] }
  let(:heroku_client) { double(releases: releases, rollback: nil) }

  before { HerokuClient.stub(new: heroku_client) }

  describe "#index" do
    it "calls releases on HerokuClient" do
      heroku_client.should_receive(:releases)
      get :index
    end
  end

  describe "#rollback" do
    it "calls rollback on HerokuClient" do
      heroku_client.should_receive(:rollback).with("123")
      get :rollback, id: "123"
    end
  end
end
