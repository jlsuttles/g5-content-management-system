require "spec_helper"

describe Api::V1::RemoteWebLayoutsController do
  describe "#index" do
    it "finds all remote web layouts" do
      WebLayout.should_receive(:all_remote).once
      get :index
    end

    it "renders location as json with serializer" do
      RemoteWebLayoutSerializer.should_receive(:new).exactly(WebLayout.all_remote.length).times
      get :index
    end
  end
end
