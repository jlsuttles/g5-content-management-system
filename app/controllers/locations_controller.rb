class LocationsController < ApplicationController
  
  def index
    @locations = Location.order("updated_at DESC").all
  end
  
  def show
    @location = Location.find_by_urn(params[:id])
  end

  def deploy
    @location = Location.find_by_urn(params[:id])
    @location.async_deploy
    redirect_to locations_path, notice: "Deploying location #{@location.heroku_url}."
  end
  
end
