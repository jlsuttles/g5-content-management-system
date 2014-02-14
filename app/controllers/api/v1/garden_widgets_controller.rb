class Api::V1::GardenWidgetsController < Api::V1::ApplicationController
  def index
    render json: GardenWidget.all
  end
end
