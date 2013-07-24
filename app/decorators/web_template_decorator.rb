class WebTemplateDecorator < Draper::Decorator
  delegate_all

  liquid_methods :display, :title, :url

  def display
    true
  end

  def url
    if web_home_template?
      "/"
    else
      "/#{slug}.html"
    end
  end
end
