class Api::V1::RemoteWidgetsController < Api::V1::ApplicationController
  def index
    render json: Widget.all_remote
  end
end
