class Api::V1::GardenWebThemesController < Api::V1::ApplicationController
  def index
    render json: GardenWebTheme.all
  end

  def update
    Resque.enqueue(GardenWebThemeUpdaterJob)
    redirect_to root_path, notice: "Updating Themes. This may take a few minutes."
  end
end
