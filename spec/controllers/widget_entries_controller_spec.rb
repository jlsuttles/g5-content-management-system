require 'spec_helper'

describe WidgetEntriesController do
  let(:widget_entry) { Fabricate.build(:widget_entry) }
  before do
    WidgetEntry.stub(:find).and_return(widget_entry)
  end

  describe "#index" do
    it "index action should render index template" do
      get :index
      response.should render_template(:index)
    end
  end

  describe "#show" do
    it "show action should render show template" do
      get :show, id: 1
      response.should render_template(:show)
    end
  end
end
