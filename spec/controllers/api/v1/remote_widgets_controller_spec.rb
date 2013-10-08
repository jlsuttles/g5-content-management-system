require "spec_helper"

describe Api::V1::RemoteWidgetsController, vcr: VCR_OPTIONS do
  describe "#index" do
    it "finds all remote widgets" do
      Widget.should_receive(:all_remote).once
      get :index
    end

    it "renders location as json with serializer" do
      RemoteWidgetSerializer.should_receive(:new).exactly(Widget.all_remote.length).times
      get :index
    end
  end
end
