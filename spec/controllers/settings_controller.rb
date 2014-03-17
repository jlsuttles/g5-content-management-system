require 'spec_helper'

describe SettingsController do
  let(:setting) { Fabricate.build(:setting) }

  it_should_behave_like 'a secure controller'

  describe "#index", :auth_controller do
    it "index action should render index template" do
      get :index
      response.should render_template(:index)
    end
  end
end
