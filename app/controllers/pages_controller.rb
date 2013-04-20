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
    render :layout => 'builder'
  end

  def update
    @page = @location.pages.find(params[:id])
    if @page.update_attributes(params[:page])
      @page.reload
      respond_to do |format|
        format.json { render json: @page.widgets.last }
        format.html { redirect_to @location, :notice => "Successfully updated page." }
      end
    else
      render :edit
    end
  end

  def show
    @page = @location.pages.find(params[:id])
  end

  def preview
    @page = @location.pages.find(params[:id])
    render layout: "compiled_pages",
      locals: { page: @page, location: @location, mode: "preview" }
  end

  def toggle_disabled
    if page = @location.pages.find(params[:id])
      page.update_attribute(:disabled, params[:disabled])
    end
    respond_to do |format|
      format.json { render json: {success: true} }
    end
  end

  private

  def find_location
    @location = Location.find_by_urn(params[:location_id])
  end
end
