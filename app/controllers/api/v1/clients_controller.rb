class Api::V1::ClientsController < Api::V1::ApplicationController
  def show
    render json: Client.first
  end
end
