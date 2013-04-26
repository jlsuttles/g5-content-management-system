require 'spec_helper'

describe WebsitesController do
  let(:website) { Fabricate(:website) }

  before(:each) do
    Website.stub(:find_by_urn).and_return(website)
  end

  describe "#show" do
    before do
      get :show, id: 1
    end
    it "show action should render show template" do
      response.should render_template(:show)
    end
    it "assigns website" do
      assigns(:website).should eq website
    end
    it "assigns website_template" do
      assigns(:website_template).should eq website.website_template
    end
    it "assings web_page_templates only the navigateable templates orderd by created at" do
      assigns(:web_page_templates).should eq website.web_templates.navigateable.created_at_asc
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
