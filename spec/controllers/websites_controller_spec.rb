require 'spec_helper'

describe WebsitesController do
  let(:website) { Fabricate.build(:website) }

  before(:each) do
    Website.stub(:find_by_urn).and_return(website)
  end

  describe "#show" do
    it "show action should render show template" do
      get :show, id: 1
      response.should render_template(:show)
    end
  end

  describe "#deploy" do
    it "redirects to locations" do
      Resque.stub(:enqueue).and_return(true)
      post :deploy, id: 1
      response.should redirect_to locations_path
    end
  end
end
