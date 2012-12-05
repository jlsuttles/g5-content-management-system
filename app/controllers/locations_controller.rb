class LocationsController < ApplicationController
  
  def index
    @locations = Location.order("updated_at DESC").all
  end
  
  def show
    @location = Location.find(params[:id])
  end

  def deploy
    @location = Location.find(params[:id])
    @location.async_deploy
    redirect_to locations_path, notice: "Deploying location #{@location.heroku_url}."
  end
  
  def compile
    @location = Location.find(params[:id])
    create_compiled_folder
    redirect_to :back, notice: "Successfully compiled #{@location.name}."
  end
  
  def create_compiled_folder
    @location.create_root_directory
    @location.pages.each do |page|
      @page = page
      File.open(@page.compiled_file_path, 'w') { |file| file << render_to_string("/pages/preview", layout: false) }
    end
  end
  helper_method :create_compiled_folder
end
