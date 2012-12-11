class PagesController < ApplicationController
  before_filter :find_location
  def index
    @pages = Page.all
  end

  def new
    @page = Page.new
  end

  def create
    @page = @location.pages.new(params[:page])
    if @page.save
      redirect_to @location, :notice => "Successfully created page."
    else
      render :action => 'new'
    end
  end
  
  def edit
    @page = @location.pages.find(params[:id])
  end
  
  def update
    @page = @location.pages.find(params[:id])
    @page.mark_widgets_for_destruction
    if @page.update_attributes(params[:page])
      redirect_to @location, :notice => "Successfully updated page."
    else
      render :edit
    end
  end

  def show
    @page = @location.pages.find(params[:id])
  end
  
  def preview
    @page = @location.pages.find(params[:id])
    render layout: false, :locals => {:page => @page, location: @location} 
  end
  
  private
  
  def find_location
    @location = Location.find_by_urn(params[:location_id])
  end
end
