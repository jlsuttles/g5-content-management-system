require 'spec_helper'

describe FeaturesController do

  before(:each) do
    @feature = Fabricate(:feature)
  end

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
end
