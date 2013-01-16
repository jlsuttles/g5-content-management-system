require 'spec_helper'

describe LocationsController do
  let(:location) { Fabricate(:location) }
  before(:each) do
    PageLayout.any_instance.stub(:assign_attributes_from_url)
  end
  
  describe "#index" do
    it "index action should render index template" do
      get :index
      response.should render_template(:index)
    end
  end
  
  describe "#show" do
    it "show action should render show template" do
      get :show, id: location.id
      response.should render_template(:show)
    end
  end

  describe "#deploy" do
    it "redirects to locations" do
      Resque.stub(:enqueue) { true }
      post :deploy, id: location.urn
      response.should redirect_to locations_path
    end
  end
end
