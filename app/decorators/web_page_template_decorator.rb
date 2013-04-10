class WebPageTemplateDecorator < Draper::Decorator
  delegate_all

  liquid_methods :display, :title, :url

  def display
    true
  end

  def url
    "/foo"
  end
end
