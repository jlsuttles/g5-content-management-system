require 'spec_helper'

describe LocationsController do

  before(:each) do
    PageLayout.any_instance.stub(:assign_attributes_from_url)
    @location = Fabricate(:location)
  end

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => Location.first
    response.should render_template(:show)
  end

end
