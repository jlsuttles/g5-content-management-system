require 'spec_helper'

describe TagsController do
  let(:tag) { "sometag" }

  it_should_behave_like 'a secure controller'

  describe "#show", :auth_controller do
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
