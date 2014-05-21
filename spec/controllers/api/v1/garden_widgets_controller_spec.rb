require "spec_helper"

describe Api::V1::GardenWidgetsController, :auth_controller, vcr: VCR_OPTIONS do
  describe "#index" do
    it "finds all garden widgets" do
      GardenWidget.should_receive(:all).once
      get :index
    end
  end
end
