require 'spec_helper'

describe WidgetEntriesController do
  let(:widget_entry) { WidgetEntry.create }

  describe "#index" do
    it "index action should render index template" do
      get :index
      response.should render_template(:index)
    end
  end

  describe "#show" do
    it "show action should render show template" do
      get :show, id: widget_entry.id
      response.should render_template(:show)
    end
  end
end
