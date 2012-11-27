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
      redirect_to [@location, @page], :notice => "Successfully created pages."
    else
      render :action => 'new'
    end
  end

  def show
    @page = Page.find(params[:id])
  end
  
  def preview
    @page = Page.find(params[:id])
    render layout: false
  end
  
  private
  
  def find_location
    @location = Location.find(params[:location_id])
  end
end
