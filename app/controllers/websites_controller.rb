class WebsitesController < ApplicationController
  def show
    @website = Website.find_by_urn(params[:id]).decorate
  end

  def deploy
    @website = Website.find_by_urn(params[:id])
    @website.async_deploy
    redirect_to locations_path, notice: "Deploying website #{@website.name}."
  end
end
