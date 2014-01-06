class WebPageTemplateDecorator < Draper::Decorator
  delegate_all

  liquid_methods :display, :title, :url

  def display
    true
  end

  def url
    "/#{client.vertical_slug}/#{location.state_slug}/#{location.city_slug}/#{slug}/"
  end
end
