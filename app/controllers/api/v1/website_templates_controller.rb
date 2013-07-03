class Api::V1::WebsiteTemplatesController < Api::V1::ApplicationController
  def show
    render json: WebsiteTemplate.find(params[:id])
  end

  def update
    @website_template = WebsiteTemplate.find(params[:id])
    if @website_template.update_attributes(website_template_params)
      render json: @website_template
    else
      render json: @website_template.errors, status: :unprocessable_entity
    end
  end

  private

  def website_template_params
    params.require(:website_template).permit(:name)
  end
end
