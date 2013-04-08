class LocationsController < ApplicationController

  def index
    @locations = Location.order("updated_at DESC").decorate
  end

  def show
    @location = Location.find_by_urn(params[:id]).decorate
  end

  def deploy
    @location = Location.find_by_urn(params[:id])
    @location.website.async_deploy
    redirect_to locations_path, notice: "Deploying location #{@location.name}."
  end

end
