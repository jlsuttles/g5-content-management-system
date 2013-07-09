class Api::V1::WidgetsController < Api::V1::ApplicationController
  def index
    render json: Widget.find(params[:ids])
  end

  def show
    render json: Widget.find(params[:id])
  end
end
