class Api::V1::ClientsController < Api::V1::ApplicationController
  def show
    render json: Client.find(params[:id])
  end
end
