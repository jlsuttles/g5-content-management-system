require 'spec_helper'

describe LocationsController do
  let(:location) { Fabricate.build(:location) }

  it_should_behave_like 'a secure controller'

  context "with an authenticated user", :auth_controller do

    describe "#index" do
      it "index action should render index template" do
        get :index
        response.should render_template(:index)
      end
    end

  end
end
