require 'spec_helper'

describe WebsiteTemplatesController do
  let(:location) { Fabricate(:location) }
  before { WebsiteTemplate.stub(:find) { location.website_template } }
  describe "#edit" do
    it "renders the web_templates template" do
      get :edit, id: 1, location_id: location.urn
      response.should render_template "web_templates/edit"
    end

    it "assigns the location attr" do
      get :edit, id: 1, location_id: location.urn
      assigns(:location).should eq location
    end
  end

  describe "#update" do
    it "updates the object" do
      put :update, id: 1, location_id: location.urn, website_template: {name: "Some Template"}
      location.website_template.reload.name.should eq "Some Template"
    end
  end

end
