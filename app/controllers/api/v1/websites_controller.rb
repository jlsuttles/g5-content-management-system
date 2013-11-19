class Api::V1::WebsitesController < Api::V1::ApplicationController
  def index
    render json: Website.all
  end

  def show
    render json: Website.find(params[:id])
  end

  def update
    @website = Website.find(params[:id])
    if @website.update_attributes(website_params)
      render json: @website
    else
      render json: @website.errors, status: :unprocessable_entity
    end
  end

  private

  def website_params
    params.require(:website).permit(:custom_colors, :primary_color, :secondary_color)
  end
end
