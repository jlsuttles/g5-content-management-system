class SiteTemplatesController < ApplicationController
  before_filter :find_location
  layout 'builder'

  def edit
    @page = SiteTemplate.find(params[:id])
    render :"/pages/edit"
  end

  def update
    @page = SiteTemplate.find(params[:id])
    if @page.update_attributes(params[:site_template])
      @page.reload
      respond_to do |format|
        format.json { render json: @page.widgets.last }
        format.html { redirect_to @location, :notice => "Successfully updated site template." }
      end

    else
      @page = SiteTemplate.find(params[:id])
      render :"/pages/edit"
    end
  end

  private
  def find_location
    @location = Location.find_by_urn(params[:location_id])
  end

end
