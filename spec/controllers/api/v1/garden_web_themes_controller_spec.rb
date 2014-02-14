require "spec_helper"

describe Api::V1::GardenWebThemesController, vcr: VCR_OPTIONS do
  describe "#index" do
    it "finds all garden web themes" do
      GardenWebTheme.should_receive(:all).once
      get :index
    end
  end
end
