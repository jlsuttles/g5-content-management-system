require 'spec_helper'

describe WebsitesController do
  let(:website) { Fabricate(:website) }

  before(:each) do
    Website.stub(:find).and_return(website)
  end

  describe "#deploy" do
    it "redirects to root" do
      Resque.stub(:enqueue).and_return(true)
      post :deploy, id: 1
      response.should redirect_to root_path
    end
  end
end
