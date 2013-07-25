class Api::V1::WebPageTemplatesController < Api::V1::ApplicationController
  def show
    render json: WebPageTemplate.find(params[:id])
  end
end
