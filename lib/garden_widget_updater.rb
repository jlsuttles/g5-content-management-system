class GardenWidgetUpdater
  def update_all
    updated_garden_widgets = []

    GardenWidget.component_microformats.map do |component|
      garden_widget = GardenWidget.find_or_initialize(url: get_url(component))
      update(garden_widget, component)
      updated_garden_widgets << garden_widget
    end

    deleted_garden_widgets = GardenWidget.all - updated_garden_widgets
    deleted_garden_widgets.destroy_all
  end

  def update(garden_widget, component=nil)
    component ||= get_component(gardent_widget)
    garden_widget.name = get_name(component)
    garden_widget.thumbnail = get_thumbnail(component)
    garden_widget.edit_html = get_edit_html(component)
    garden_widget.edit_javascript = get_edit_javascript(component)
    garden_widget.show_html = get_show_html(component)
    garden_widget.show_javascript = get_show_javascript(component)
    garden_widget.lib_javascripts = get_lib_javascripts(component)
    garden_widget.show_stylesheets = get_show_stylesheets(component)
    garden_widget.settings = get_settings(component)
    garden_widget.save
  end

  private

  def get_component(garden_widget)
    component = Microformats2.parse(garden_widget.url).first
    raise "No h-g5-component found at url: #{url}" unless component
    component
  rescue OpenURI::HTTPError => e
    Rails.logger.warn e.message
  end
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

  def get_edit_html(component)
    if component.respond_to(:g5_edit_template)
      url = component.g5_edit_template.to_s
      open(url).read if url
    end
  end

  def get_edit_javascript(component)
    if component.respond_to?(:g5_edit_javascript)
      component.g5_edit_javascript.to_s
    end
  end

  def get_show_html(component)
    if component.respond_to(:g5_show_template)
      url = component.g5_show_template.to_s
      open(url).read if url
    end
  end

  def get_show_javascript(component)
    if component.respond_to?(:g5_show_javascript)
      component.g5_show_javascript.to_s
    end
  end

  def get_show_stylesheets(component)
    if component.respond_to?(:g5_stylesheets)
      component.g5_stylesheets.try(:map) { |s| s.to_s }
    end
  end

  def get_lib_javascripts(component)
    if component.respond_to?(:g5_lib_javascripts)
      component.g5_lib_javascripts.try(:map) { |j| j.to_s }
    end
  end

  def get_settings(component)
    settings = []
    if component.respond_to?(:g5_property_groups)
      e_property_groups = component.g5_property_groups
      e_property_groups.each do |e_property_group|
        h_property_group = e_property_group.format
        h_property_group.g5_properties.each do |e_property|
          settings << {
            name: h_property.g5_name.to_s,
            editable: h_property.g5_editable.to_s || false,
            default_value: h_property.g5_default_value.to_s,
            categories: h_property_group.try(:categories).try(:map, &:to_s)
          }
        end
      end
    end
    settings
  end
end
