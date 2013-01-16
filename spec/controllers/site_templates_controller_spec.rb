require 'spec_helper'

describe SiteTemplatesController do
  let(:location) { Fabricate(:location) }
  before { SiteTemplate.stub(:find) { location.site_template } }
  describe "#edit" do
    it "renders the pages template" do
      get :edit, id: 1, location_id: location.urn
      response.should render_template "pages/edit"
    end
    
    it "assigns the location attr" do
      get :edit, id: 1, location_id: location.urn
      assigns(:location).should eq location
    end
  end

  describe "#update" do
    it "updates the object" do
      put :update, id: 1, location_id: location.urn, site_template: {name: "Some Template"}
      location.site_template.reload.name.should eq "Some Template"
    end
  end

end
