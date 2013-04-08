require 'spec_helper'

describe TagsController do
  let(:tag) { "sometag" }

  describe "#show" do
    it "show action should render show template" do
      get :show, id: tag
      response.should render_template(:show)
    end
    it "assigs params[:id] to @tag" do
      get :show, id: tag
      assigns(:tag).should eq "sometag"
    end
  end
end
