class Api::V1::WebsiteTemplatesController < Api::V1::ApplicationController
  def show
    render json: WebsiteTemplate.find(params[:id])
  end
end
