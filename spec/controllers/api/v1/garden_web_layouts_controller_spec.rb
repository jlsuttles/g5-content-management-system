require "spec_helper"

describe Api::V1::GardenWebLayoutsController, :auth_controller, vcr: VCR_OPTIONS do
  describe "#index" do
    it "finds all garden web layouts" do
      GardenWebLayout.should_receive(:all).once
      get :index
    end
  end
end
