class Api::V1::WebPageTemplatesController < Api::V1::ApplicationController
  def create
    @web_page_template = WebPageTemplate.new(web_page_template_params)
    @main_drop_target = @web_page_template.drop_targets.build(html_id: "drop-target-main")
    
    if @web_page_template.save && @main_drop_target.save
      render json: @web_page_template
    else
      render json: @web_page_template.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: WebPageTemplate.find(params[:id])
  end

  def update
    @web_page_template = WebPageTemplate.find(params[:id])
    if @web_page_template.update_attributes(web_page_template_params)
      render json: @web_page_template
    else
      render json: @web_page_template.errors, status: :unprocessable_entity
    end
  end

  private

  def web_page_template_params
    params.require(:web_page_template).permit(:website_id, :name, :title, :disabled)
  end
end
