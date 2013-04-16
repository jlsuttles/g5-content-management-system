require 'spec_helper'

describe SettingsController do
  let(:setting) { Fabricate.build(:setting) }

  describe "#index" do
    it "index action should render index template" do
      get :index
      response.should render_template(:index)
    end
  end
end
