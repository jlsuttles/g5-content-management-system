class WebHomeTemplateDecorator < Draper::Decorator
  delegate_all

  liquid_methods :display, :title, :url

  def display
    true
  end

  def url
    "/"
  end

  def canonical_link_element
    "<link class='canonical' rel='canonical' href='#{website.decorate.heroku_url}' />"
  end
end
