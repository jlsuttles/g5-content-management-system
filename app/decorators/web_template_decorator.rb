class WebTemplateDecorator < Draper::Decorator
  delegate_all

  liquid_methods :display, :title, :url

  def display
    true
  end

  def url
    if homepage?
      "/"
    else
      "/#{slug}.html"
    end
  end
end
