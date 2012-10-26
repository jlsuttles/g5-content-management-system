require 'spec_helper'

describe LocationsController do
  fixtures :all
  render_views

  before(:each) do
    @client = Fabricate(:client)
    session[:client_id] = @client.id
  end

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => Location.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    Location.any_instance.stub(:valid?).and_return(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    Location.any_instance.stub(:valid?).and_return(true)
    post :create
    response.should redirect_to(location_url(assigns[:location]))
  end

  it "edit action should render edit template" do
    get :edit, :id => Location.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    Location.any_instance.stub(:valid?).and_return(false)
    put :update, :id => Location.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    Location.any_instance.stub(:valid?).and_return(true)
    put :update, :id => Location.first
    response.should redirect_to(location_url(assigns[:location]))
  end

  it "destroy action should destroy model and redirect to index action" do
    location = Location.first
    delete :destroy, :id => location
    response.should redirect_to(locations_url)
    Location.exists?(location.id).should be_false
  end
end
