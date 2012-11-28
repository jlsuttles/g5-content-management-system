require File.dirname(__FILE__) + '/../spec_helper'

describe PagesController do

  before { 
    Location.stub(:find) { Location.create }
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
    response.should redirect_to(location_pages_url(assigns[:location], assigns[:pages]))
  end

  it "show action should render show template" do
    Page.stub(:find).with("1") {Page.new}
    get :show, :id => 1, location_id: 1
    response.should render_template(:show)
  end
end
