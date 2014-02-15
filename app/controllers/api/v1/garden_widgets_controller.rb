class Api::V1::GardenWidgetsController < Api::V1::ApplicationController
  def index
    render json: GardenWidget.all
  end

  def update
    Resque.enqueue(GardenWidgetUpdaterJob)
    redirect_to root_path, notice: "Updating Widgets. This may take a few minutes."
  end
end
