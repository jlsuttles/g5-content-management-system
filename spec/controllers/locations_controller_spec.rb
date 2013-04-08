require 'spec_helper'

describe LocationsController do
  let(:location) { Fabricate.build(:location_with_website) }

  before(:each) do
    Location.stub(:find_by_urn).and_return(location)
  end

  describe "#index" do
    it "index action should render index template" do
      get :index
      response.should render_template(:index)
    end
  end
end
