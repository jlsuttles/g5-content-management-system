class WebsiteTemplatesController < WebTemplatesController
  private
  def web_template_klass
    WebsiteTemplate
  end

  def web_template_params
    params[:website_template]
  end
end
