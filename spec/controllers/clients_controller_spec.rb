require 'spec_helper'

describe ClientsController do
  fixtures :all
  render_views

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    Client.any_instance.stub(:valid?).and_return(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    Client.any_instance.stub(:valid?).and_return(true)
    post :create
    response.should redirect_to(root_url)
    session['client_id'].should == assigns['client'].id
  end

  it "edit action should redirect when not logged in" do
    get :edit, :id => "ignored"
    response.should redirect_to(login_url)
  end

  it "edit action should render edit template" do
    @controller.stub!(:current_client).and_return(Client.first)
    get :edit, :id => "ignored"
    response.should render_template(:edit)
  end

  it "update action should redirect when not logged in" do
    put :update, :id => "ignored"
    response.should redirect_to(login_url)
  end

  it "update action should render edit template when client is invalid" do
    @controller.stub!(:current_client).and_return(Client.first)
    Client.any_instance.stub(:valid?).and_return(false)
    put :update, :id => "ignored"
    response.should render_template(:edit)
  end

  it "update action should redirect when client is valid" do
    @controller.stub!(:current_client).and_return(Client.first)
    Client.any_instance.stub(:valid?).and_return(true)
    put :update, :id => "ignored"
    response.should redirect_to(root_url)
  end
end
