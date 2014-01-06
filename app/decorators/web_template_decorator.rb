class WebTemplateDecorator < Draper::Decorator
  delegate_all

  liquid_methods :display, :title, :url

  def display
    true
  end

  def vertical
    client.try(:vertical_slug)
  end

  def city
    location.try(:city_slug)
  end

  def state
    location.try(:state_slug)
  end

  def url
    if web_home_template?
      "/"
    else
      "/#{vertical}/#{state}/#{city}/#{slug}/"
    end
  end
end
