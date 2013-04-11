class WebPageTemplatesController < WebTemplatesController
  private
  def web_template_klass
    WebPageTemplate
  end

  def web_template_params
    params[:web_page_template]
  end
end
