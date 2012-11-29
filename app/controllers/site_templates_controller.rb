class SiteTemplatesController < ApplicationController
  before_filter :find_location  
  def edit
    @page = SiteTemplate.find_by_slug(params[:id])
    render :"/pages/edit"
  end
  
  def update
    @page = Page.find_by_slug(params[:id])
    @page.mark_widgets_for_destruction
    if @page.update_attributes(params[:site_template])
      redirect_to @location, :notice => "Successfully updated site template."
    else
      @page = SiteTemplate.find_by_slug(params[:id])
      render :"/pages/edit"
    end
  end
  def find_location
    @location = Location.find(params[:location_id])
  end
  
end
