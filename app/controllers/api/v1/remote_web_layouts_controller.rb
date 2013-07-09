class Api::V1::RemoteWebLayoutsController < Api::V1::ApplicationController
  def index
    render json: WebLayout.all_remote
  end
end
