class Api::V1::WidgetsController < Api::V1::ApplicationController
  def index
    render json: Widget.all_remote
  end

  def show
    render json: Widget.find(params[:id])
  end
end
