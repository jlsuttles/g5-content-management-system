class Api::V1::GardenWebThemesController < Api::V1::ApplicationController
  def index
    render json: GardenWebTheme.all
  end
end
