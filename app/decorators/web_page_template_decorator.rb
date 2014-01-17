class WebPageTemplateDecorator < Draper::Decorator
  delegate_all

  liquid_methods :display, :title, :url

  def display
    true
  end

  def url
    "/#{slug}.html"
  end

  def canonical_link_element
    "<link rel='canonical' href='/#{relative_path}' />"
  end
end
