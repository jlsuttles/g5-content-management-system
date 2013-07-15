class WebsiteTemplateSerializer < ActiveModel::Serializer
  attributes  :id,
              :web_layout_id,
              :web_theme_id,
              :widget_ids

  def web_layout_id
    object.web_layout.id
  end

  def web_theme_id
    object.web_theme.id
  end
end
