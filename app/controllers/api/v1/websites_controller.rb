class Api::V1::WebsitesController < Api::V1::ApplicationController
  def show
    render json: Website.find(params[:id])
  end
end
