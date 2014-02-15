class Api::V1::GardenWebLayoutsController < Api::V1::ApplicationController
  def index
    render json: GardenWebLayout.all
  end

  def update
    Resque.enqueue(GardenWebLayoutUpdaterJob)
    redirect_to root_path, notice: "Updating Layouts. This may take a few minutes."
  end
end
