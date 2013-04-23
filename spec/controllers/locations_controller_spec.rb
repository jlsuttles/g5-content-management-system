require 'spec_helper'

describe LocationsController do
  let(:location) { Fabricate.build(:location) }

  describe "#index" do
    it "index action should render index template" do
      get :index
      response.should render_template(:index)
    end
  end
end
