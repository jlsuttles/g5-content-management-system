require 'spec_helper'

describe LocationsController do
  let(:tag) { "sometag" }

  describe "#show" do
    it "show action should render show template" do
      get :show, id: tag
      response.should render_template(:show)
    end
  end
end
