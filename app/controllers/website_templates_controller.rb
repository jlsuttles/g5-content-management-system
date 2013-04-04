class WebsiteTemplatesController < ApplicationController
  before_filter :find_location
  layout 'builder'

  def edit
    @web_template = WebsiteTemplate.find(params[:id])
    render :"/web_templates/edit"
  end

  def update
    @web_template = WebsiteTemplate.find(params[:id])
    if @web_template.update_attributes(params[:website_template])
      @web_template.reload
      respond_to do |format|
        format.json { render json: @web_template.widgets.last }
        format.html { redirect_to @location, :notice => "Successfully updated site template." }
      end

    else
      @web_template = WebsiteTemplate.find(params[:id])
      render :"/web_templates/edit"
    end
  end

  private

  def find_location
    @location = Location.find_by_urn(params[:location_id])
  end

end
