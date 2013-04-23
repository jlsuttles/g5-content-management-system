class LocationsController < ApplicationController
  def index
    @locations = Location.order("updated_at DESC").decorate
  end
end
