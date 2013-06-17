class Api::V1::WebLayoutsController < Api::V1::ApplicationController
  def index
    render json: WebLayout.all_remote
  end

  def show
    render json: WebLayout.find(params[:id])
  end
end
