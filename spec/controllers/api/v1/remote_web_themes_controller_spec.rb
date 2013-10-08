require "spec_helper"

describe Api::V1::RemoteWebThemesController do
  describe "#index" do
    it "finds all remote web themes" do
      WebTheme.should_receive(:all_remote).once
      get :index
    end

    it "renders location as json with serializer" do
      RemoteWebThemeSerializer.should_receive(:new).exactly(WebTheme.all_remote.length).times
      get :index
    end
  end
end
