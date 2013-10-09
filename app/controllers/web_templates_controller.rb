class WebTemplatesController < ApplicationController
  def show
    @website = Website.find_by_urn(params[:website_id])
    @web_template = WebTemplate.find(params[:id])

    render "web_templates/show",
      layout: "compiled_pages",
      locals: {
        website: @website,
        web_template: @web_template,
        location: @web_template.website.location,
        mode: "preview"
      }
  end
end
