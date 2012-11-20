class LocationsController < ApplicationController
  def index
    @locations = Location.order("updated_at DESC").all
  end

  def deploy
    @location = Location.find(params[:id])
    @location.async_deploy
    redirect_to locations_path, notice: "Deploying location #{@location.heroku_url}."
  end
end
