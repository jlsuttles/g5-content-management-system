class GardenWebLayoutUpdater
  def update_all
    updated_garden_web_layouts = []

    components_microformats.map do |component|
      garden_web_layout = GardenWebLayout.find_or_initialize_by(name: get_name(component))
      update(garden_web_layout, component)
      updated_garden_web_layouts << garden_web_layout
    end if components_microformats

    removed_garden_web_layouts = GardenWebLayout.all - updated_garden_web_layouts
    removed_garden_web_layouts.each do |removed_garden_web_layout|
      unless removed_garden_web_layout.in_use?
        removed_garden_web_layout.destroy
      end
    end
  end

  def update(garden_web_layout, component=nil)
    component ||= garden_web_layout.component_microformat
    garden_web_layout.url = get_url(component)
    garden_web_layout.name = get_name(component)
    garden_web_layout.slug = get_slug(component)
    garden_web_layout.thumbnail = get_thumbnail(component)
    garden_web_layout.html = get_html(component)
    garden_web_layout.stylesheets = get_stylesheets(component)
    garden_web_layout.save
  end

  private

  def components_microformats
    GardenWebLayout.components_microformats
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

  def get_slug(component)
    if component.respond_to?(:name)
      component.name.to_s.parameterize
    end
  end

  def get_thumbnail(component)
    if component.respond_to?(:photo)
      component.photo.to_s
    end
  end

  def get_html(component)
    if component.respond_to?(:content)
      CGI.unescapeHTML(component.content.to_s)
    end
  end

  def get_stylesheets(component)
    if component.respond_to?(:g5_stylesheets)
      component.g5_stylesheets.try(:map) { |s| s.to_s }
    end
  end
end
