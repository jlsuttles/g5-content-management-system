class Api::V1::WebHomeTemplatesController < Api::V1::ApplicationController
  def show
    render json: WebHomeTemplate.find(params[:id])
  end

  def update
    @web_home_template = WebHomeTemplate.find(params[:id])
    if @web_home_template.update_attributes(web_home_template_params)
      render json: @web_home_template
    else
      render json: @web_home_template.errors, status: :unprocessable_entity
    end
  end

  private

  def web_home_template_params
    params.require(:web_home_template).permit(:website_id, :name, :title, :disabled)
  end
end
