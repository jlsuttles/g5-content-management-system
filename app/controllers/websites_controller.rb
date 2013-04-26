class WebsitesController < ApplicationController
  def show
    @website = Website.find_by_urn(params[:id]).decorate
    @website_template = @website.website_template
    @web_page_templates = @website.web_templates.navigateable.created_at_asc
  end

  def deploy
    @website = Website.find_by_urn(params[:id])
    @website.async_deploy
    redirect_to locations_path, notice: "Deploying website #{@website.name}."
  end
end
