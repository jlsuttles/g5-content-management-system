class WebLayoutSerializer < ActiveModel::Serializer
  attributes  :id,
              :garden_web_layout_id,
              :website_template_id,
              :name,
              :thumbnail,
              :url

  def website_template_id
    object.web_template_id
  end
end
