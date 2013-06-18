class Api::V1::WebLayoutsController < Api::V1::ApplicationController
  def show
    render json: WebLayout.find(params[:id])
  end
end
