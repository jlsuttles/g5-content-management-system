class WebPageTemplatesController < ApplicationController
  before_filter :find_website

  def index
    @web_templates = WebPageTemplate.all
    render :"/web_templates/index"
  end

  def new
    @web_template = WebPageTemplate.new
    render :"/web_templates/new"
  end

  def create
    @web_template = @website.web_page_templates.new(params[:web_page_template])
    if @web_template.save
      redirect_to @website, :notice => "Successfully created page."
    else
      render :"/web_templates/new"
    end
  end

  def edit
    @web_template = @website.web_page_templates.find(params[:id])
    render :"/web_templates/edit", :layout => 'builder'
  end

  def update
    @web_template = @website.web_page_templates.find(params[:id])
    if @web_template.update_attributes(params[:web_page_template])
      @web_template.reload
      respond_to do |format|
        format.json { render json: @web_template.widgets.last }
        format.html { redirect_to @website, :notice => "Successfully updated page." }
      end
    else
      render :"/web_templates/edit", :layout => 'builder'
    end
  end

  def show
    @web_template = @website.web_page_templates.find(params[:id])
    render :"/web_templates/show"
  end

  def preview
    @web_template = @website.web_page_templates.find(params[:id])
    render :"/web_templates/preview", layout: "compiled_pages",
      locals: { web_template: @web_template, website: @website, mode: "preview" }
  end

  private

  def find_website
    @website = Website.find_by_urn(params[:website_id])
  end
end
