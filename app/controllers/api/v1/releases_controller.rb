class Api::V1::ReleasesController < Api::V1::ApplicationController
  def index
    render json: heroku_client.releases.reverse.first(10)
  end

  def rollback
    heroku_client.rollback(params[:id])
    redirect_to root_path, notice: "Rolling Back. This may take a few minutes."
  end

  protected

  def heroku_client
    HerokuClient.new(ENV["HEROKU_APP_NAME"], ENV["HEROKU_API_KEY"])
  end
end
