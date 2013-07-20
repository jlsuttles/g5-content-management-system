class WebsiteTemplateSerializer < ActiveModel::Serializer
  attributes  :id,
              :web_layout_id,
              :web_theme_id,
              :widget_ids,
              :logo_widget_ids,
              :phone_widget_ids,
              :btn_widget_ids,
              :nav_widget_ids,
              :aside_widget_ids,
              :footer_widget_ids,
              :location_id,
              :website_urn,
              :web_home_template_id

  def web_layout_id
    object.web_layout.id
  end

  def web_theme_id
    object.web_theme.id
  end

  def location_id
    object.location.id
  end

  # Properties for constructing the Ember live preview URL
  def website_urn
    object.location.website.urn
  end

  def web_home_template_id
    object.location.web_home_template.id
  end
end
