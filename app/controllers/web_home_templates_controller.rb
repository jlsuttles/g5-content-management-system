class WebHomeTemplatesController < ApplicationController
  before_filter :find_location

  def edit
    @web_template = WebHomeTemplate.find(params[:id])
    render :"/web_templates/edit", :layout => 'builder'
  end

  def update
    @web_template = WebHomeTemplate.find(params[:id])
    if @web_template.update_attributes(params[:web_home_template])
      @web_template.reload
      respond_to do |format|
        format.json { render json: @web_template.widgets.last }
        format.html { redirect_to @location, :notice => "Successfully updated page." }
      end
    else
      render :"/web_templates/edit", :layout => 'builder'
    end
  end

  def show
    @web_template = WebHomeTemplate.find(params[:id])
    render :"/web_templates/show"
  end

  def preview
    @web_template = WebHomeTemplate.find(params[:id])
    render :"/web_templates/preview", layout: "compiled_pages",
      locals: { web_template: @web_template, location: @location, mode: "preview" }
  end

  private

  def find_location
    @location = Location.find_by_urn(params[:location_id])
  end
end
