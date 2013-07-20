class Api::V1::WebHomeTemplatesController < Api::V1::ApplicationController
  def show
    render json: WebHomeTemplate.find(params[:id])
  end
end
