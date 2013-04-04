class WebPageTemplatesController < ApplicationController
  before_filter :find_location

  def index
    @web_templates = WebPageTemplate.all
    render :"/web_templates/index"
  end

  def new
    @web_template = WebPageTemplate.new
    render :"/web_templates/new"
  end

  def create
    @web_template = @location.website.web_page_templates.new(params[:web_page_template])
    if @web_template.save
      redirect_to @location, :notice => "Successfully created page."
    else
      render :"/web_templates/new"
    end
  end

  def edit
    @web_template = @location.web_page_templates.find(params[:id])
    render :"/web_templates/edit", :layout => 'builder'
  end

  def update
    @web_template = @location.web_page_templates.find(params[:id])
    if @web_template.update_attributes(params[:web_page_template])
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
    @web_template = @location.web_page_templates.find(params[:id])
    render :"/web_templates/show"
  end

  def preview
    @web_template = @location.web_page_templates.find(params[:id])
    render :"/web_templates/preview", layout: "compiled_pages",
      locals: { web_template: @web_template, location: @location, mode: "preview" }
  end

  private

  def find_location
    @location = Location.find_by_urn(params[:location_id])
  end
end
