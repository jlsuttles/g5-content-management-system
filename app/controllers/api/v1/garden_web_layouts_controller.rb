class Api::V1::GardenWebLayoutsController < Api::V1::ApplicationController
  def index
    render json: GardenWebLayout.all
  end
end
