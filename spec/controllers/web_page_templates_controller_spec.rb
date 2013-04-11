require File.dirname(__FILE__) + '/../spec_helper'

describe WebPageTemplatesController do
  before {
    @website = Fabricate(:website)
    @web_page_template = @website.web_page_templates.first
  }

  describe "#index" do
    it "index action should render index template" do
      get :index, website_id: @website.urn
      response.should render_template(:index)
    end
  end

  describe "#new" do
    it "new action should render new template" do
      get :new, website_id: @website.urn
      response.should render_template(:new)
    end
  end

  describe "#create" do
    it "create action should render new template when model is invalid" do
      WebTemplate.any_instance.stub(:save) {false}
      post :create, website_id: @website.urn
      response.should render_template(:new)
    end

    it "create action should redirect when model is valid" do
      WebTemplate.any_instance.stub(:save) {true}
      post :create, website_id: @website.urn
      response.should redirect_to(website_url(assigns[:website]))
    end
  end

  describe "#show" do
    it "show action should render show template" do
      @website.web_page_templates.stub(:find){ WebPageTemplate.new }
      get :show, :id => @web_page_template.id, website_id: @website.urn
      response.should render_template(:show)
    end
  end

  describe "#edit" do
    it "renders the edit template" do
      get :edit, id: @web_page_template.id, website_id: @website.urn
      response.should render_template(:edit)
    end
  end

  describe "#update" do
    let(:update) { put :update, id: @web_page_template.id, website_id: @website.urn, web_page_template: {name: "New Name"} }

    it "renders edit" do
      put :update, id: @web_page_template.id, website_id: @website.urn, web_page_template: {name: nil}
      response.should render_template :edit
    end
    it "redirects to the website" do
      update
      response.should redirect_to @website
    end
    it "updates a web_page_template" do
      update
      @web_page_template.reload.name.should eq "New Name"
    end
  end

  describe "#preview" do
    it "should render the preview template" do
      get :preview, :id => @web_page_template.id, website_id: @website.urn
      response.should render_template :preview
    end
  end

  describe "#toggle_disabled" do
    it "disables the page" do
      expect{
        put :toggle_disabled, id: @page.id, location_id: @location.urn, format: :js, disabled: true
      }.to change{@page.reload.disabled}.from(false).to(true)
    end
  end
end
