class Api::V1::RemoteWebThemesController < Api::V1::ApplicationController
  def index
    render json: WebTheme.all_remote
  end
end
