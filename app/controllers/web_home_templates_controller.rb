class WebHomeTemplatesController < WebTemplatesController
  private
  def web_template_klass
    WebHomeTemplate
  end

  def web_template_params
    params[:web_home_template]
  end
end
