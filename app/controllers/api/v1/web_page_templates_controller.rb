class Api::V1::WebPageTemplatesController < Api::V1::ApplicationController
  def create
    @web_page_template = WebPageTemplate.new(web_page_template_params)
    if @web_page_template.save
      render json: @web_page_template, root: klass
    else
      render json: @web_page_template.errors, root: klass, status: :unprocessable_entity
    end
  end

  def show
    render json: WebPageTemplate.find(params[:id])
  end

  private

  def web_page_template_params
    params.require(:web_page_template).permit(:website_id, :name)
  end
end
