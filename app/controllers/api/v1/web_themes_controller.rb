class Api::V1::WebThemesController < Api::V1::ApplicationController
  def index
    render json: WebTheme.all_remote
  end

  def show
    render json: WebTheme.find(params[:id])
  end
end