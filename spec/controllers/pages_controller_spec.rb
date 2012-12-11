require File.dirname(__FILE__) + '/../spec_helper'

describe PagesController do

  before {
    PageLayout.any_instance.stub(:assign_attributes_from_url)
    @location = Fabricate(:location)
    Location.stub(:find_by_urn) { @location }
    Page.any_instance.stub(:theme) { Theme.new }
    Page.any_instance.stub(:layout) { PageLayout.new }
  }
  it "index action should render index template" do
    get :index, location_id: 1
    response.should render_template(:index)
  end

  it "new action should render new template" do
    get :new, location_id: 1
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    Page.any_instance.stub(:save) {false}
    post :create, location_id: 1
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    Page.any_instance.stub(:save) {true}
    post :create, location_id: 1
    response.should redirect_to(location_url(assigns[:location]))
  end

  it "show action should render show template" do
    @location.pages.stub(:find).with("1") { Page.new }
    get :show, :id => @location.pages.first.id, location_id: 1
    response.should render_template(:show)
  end
end
