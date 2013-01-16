class SiteTemplatesController < ApplicationController
  before_filter :find_location  
  def edit
    @page = SiteTemplate.find(params[:id])
    render :"/pages/edit"
  end
  
  def update
    @page = SiteTemplate.find(params[:id])
    @page.mark_widgets_for_destruction
    if @page.update_attributes(params[:site_template])
      redirect_to @location, :notice => "Successfully updated site template."
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
