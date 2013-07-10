class Api::V1::RemoteWebThemesController < Api::V1::ApplicationController
  def index
    render json: WebTheme.all_remote, each_serializer: RemoteWebThemeSerializer
  end
end
