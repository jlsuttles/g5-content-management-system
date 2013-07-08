class Api::V1::WebLayoutsController < Api::V1::ApplicationController
  def index
    render json: WebLayout.all_remote
  end

  def show
    render json: WebLayout.find(params[:id])
  end

  def update
    @web_layout = WebLayout.find(params[:id])
    if @web_layout.update_attributes(web_layout_params)
      render json: @web_layout
    else
      render json: @web_layout.errors, status: :unprocessable_entity
    end
  end

  private

  def web_layout_params
    params.require(:web_layout).permit(:url)
  end
end
