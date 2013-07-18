class WebsiteTemplateSerializer < ActiveModel::Serializer
  attributes  :id,
              :web_layout_id,
              :web_theme_id,
              :widget_ids,
              :location_id

  def web_layout_id
    object.web_layout.id
  end

  def web_theme_id
    object.web_theme.id
  end

  def location_id
    object.location.id
  end
end
