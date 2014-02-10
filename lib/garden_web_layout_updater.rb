class GardenWebLayoutUpdater
  def update_all
    updated_garden_web_layouts = []

    WebLayout.component_microformats.map do |component|
      garden_web_layout = GardenWebLayout.find_or_initialize(url: get_url(component))
      update(garden_web_layout, component)
      updated_garden_web_layouts << garden_web_layout
    end

    deleted_garden_web_layouts = GardenWebLayout.all - updated_garden_web_layouts
    # TODO: do not destroy if in use
    deleted_garden_web_layouts.destroy_all
  end

  def update(garden_web_layout, component=nil)
    component ||= get_component(gardent_web_layout)
    garden_web_layout.name = get_name(component)
    garden_web_layout.thumbnail = get_thumbnail(component)
    garden_web_layout.html = get_html(component)
    garden_web_layout.stylesheets = get_stylesheets(component)
    garden_web_layout.save
  end

  private

  def get_component(garden_web_layout)
    component = Microformats2.parse(garden_web_layout.url).first
    raise "No h-g5-component found at url: #{url}" unless component
    component
  rescue OpenURI::HTTPError => e
    Rails.logger.warn e.message
  end

  def get_url(component)
    if component.respond_to?(:url)
      component.url.to_s
    end
  end

  def get_name(component)
    if component.respond_to?(:name)
      component.name.to_s
    end
  end

  def get_thumbnail(component)
    if component.respond_to?(:photo)
      component.photo.to_s
    end
  end

  def get_html(component)
    if component.resepond_to?(:content)
      CGI.unescapeHTML(component.content.to_s)
    end
  end

  def get_stylesheets(component)
    if component.respond_to?(:g5_stylesheets)
      component.g5_stylesheets.try(:map) { |s| s.to_s }
    end
  end
end
