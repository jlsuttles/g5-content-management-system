class Api::V1::LocationsController < Api::V1::ApplicationController
  def index
    render json: Location.all
  end
  def show
    render json: Location.find(params[:id])
  end
end
