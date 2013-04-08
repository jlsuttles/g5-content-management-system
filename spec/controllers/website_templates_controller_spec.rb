require 'spec_helper'

describe WebsiteTemplatesController do
  let(:location) { Fabricate.build(:location) }
  let(:website) { Fabricate.build(:website) }
  let(:website_template) { Fabricate.build(:website_template) }

  before do
    Location.stub(:find_by_urn) { location }
    WebsiteTemplate.stub(:find) { website_template }

    website.website_template = website_template
    location.website = website
  end

  describe "#edit" do
    it "assigns the location instance variable" do
      get :edit, location_id: location.urn, id: 1
      assigns(:location).should eq location
    end
    it "assigns the web_template instance variable" do
      get :edit, location_id: location.urn, id: 1
      assigns(:web_template).should eq website_template
    end
    it "renders the layout/builder template" do
      get :edit, location_id: location.urn, id: 1
      response.should render_template "layouts/builder"
    end
    it "renders the web_templates/edit template" do
      get :edit, location_id: location.urn, id: 1
      response.should render_template "web_templates/edit"
    end
  end

  describe "#update" do
    it "assigns the location instance variable" do
      get :update, location_id: location.urn, id: 1
      assigns(:location).should eq location
    end
    it "assigns the web_template instance variable" do
      get :update, location_id: location.urn, id: 1
      assigns(:web_template).should eq website_template
    end
    it "updates the object" do
      put :update, location_id: location.urn, id: 1,
        website_template: { name: "Some Template" }
      website_template.reload.name.should eq "Some Template"
    end
    it "when update succeeds redirects to location" do
      website_template.stub(:update_attributes).and_return(true)
      get :update, location_id: location.urn, id: 1
      response.should redirect_to location
    end
    it "when update fails renders web_templates/edit template" do
      website_template.stub(:update_attributes).and_return(false)
      get :update, location_id: location.urn, id: 1
      response.should render_template "layouts/builder"
    end
  end

end
