require 'spec_helper'

describe WebsiteTemplatesController do
  let(:website) { Fabricate.build(:website) }
  let(:website_template) { Fabricate.build(:website_template) }

  before do
    Website.stub(:find_by_urn) { website }
    WebsiteTemplate.stub(:find) { website_template }

    website.website_template = website_template
  end

  describe "#edit" do
    it "assigns the website instance variable" do
      get :edit, website_id: website.urn, id: 1
      assigns(:website).should eq website
    end
    it "assigns the web_template instance variable" do
      get :edit, website_id: website.urn, id: 1
      assigns(:web_template).should eq website_template
    end
    it "renders the layout/builder template" do
      get :edit, website_id: website.urn, id: 1
      response.should render_template "layouts/builder"
    end
    it "renders the web_templates/edit template" do
      get :edit, website_id: website.urn, id: 1
      response.should render_template "web_templates/edit"
    end
  end

  describe "#update" do
    it "assigns the website instance variable" do
      get :update, website_id: website.urn, id: 1
      assigns(:website).should eq website
    end
    it "assigns the web_template instance variable" do
      get :update, website_id: website.urn, id: 1
      assigns(:web_template).should eq website_template
    end
    it "updates the object" do
      put :update, website_id: website.urn, id: 1,
        website_template: { name: "Some Template" }
      website_template.reload.name.should eq "Some Template"
    end
    it "when update succeeds redirects to website" do
      website_template.stub(:update_attributes).and_return(true)
      get :update, website_id: website.urn, id: 1
      response.should redirect_to website_url(website)
    end
    it "when update fails renders web_templates/edit template" do
      website_template.stub(:update_attributes).and_return(false)
      get :update, website_id: website.urn, id: 1
      response.should render_template "layouts/builder"
    end
  end

end
