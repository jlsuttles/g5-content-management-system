class WebHomeTemplateDecorator < Draper::Decorator
  delegate_all

  liquid_methods :display, :title, :url

  def display
    true
  end

  def canonical_link_element
    "<link rel='canonical' href='#{page_url}' />"
  end
end
