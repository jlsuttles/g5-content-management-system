require File.dirname(__FILE__) + '/../spec_helper'

describe PagesController do
  before {
    @location = Fabricate(:location)
    @page = @location.pages.first
  }

  describe "#index" do
    it "index action should render index template" do
      get :index, location_id: @location.urn
      response.should render_template(:index)
    end
  end

  describe "#new" do
    it "new action should render new template" do
      get :new, location_id: @location.urn
      response.should render_template(:new)
    end
  end

  describe "#create" do
    it "create action should render new template when model is invalid" do
      Page.any_instance.stub(:save) {false}
      post :create, location_id: @location.urn
      response.should render_template(:new)
    end

    it "create action should redirect when model is valid" do
      Page.any_instance.stub(:save) {true}
      post :create, location_id: @location.urn
      response.should redirect_to(location_url(assigns[:location]))
    end
  end

  describe "#show" do
    it "show action should render show template" do
      @location.pages.stub(:find){ Page.new }
      get :show, :id => @page.id, location_id: @location.urn
      response.should render_template(:show)
    end
  end

  describe "#edit" do
    it "renders the edit template" do
      get :edit, id: @page.id, location_id: @location.urn
      response.should render_template(:edit)
    end
  end

  describe "#update" do
    let(:update) { put :update, id: @page.id, location_id: @location.urn, page: {name: "New Name"} }

    it "renders edit" do
      put :update, id: @page.id, location_id: @location.urn, page: {name: nil}
      response.should render_template :edit
    end
    it "redirects to the location" do
      update
      response.should redirect_to @location
    end
    it "updates a page" do
      update
      @page.reload.name.should eq "New Name"
    end
  end

  describe "#preview" do
    it "should render the preview template" do
      get :preview, :id => @page.id, location_id: @location.urn
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
