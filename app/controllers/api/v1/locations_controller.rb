class Api::V1::LocationsController < Api::V1::ApplicationController
  def show
    render json: Location.find(params[:id])
  end
end
