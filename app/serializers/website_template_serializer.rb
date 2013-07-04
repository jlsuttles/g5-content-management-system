class WebsiteTemplateSerializer < ActiveModel::Serializer
  attributes  :web_layout_id,
              :web_theme_id

  def web_layout_id
    object.web_layout.id
  end

  def web_theme_id
    object.web_theme.id
  end
end
