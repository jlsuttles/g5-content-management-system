class WebsiteTemplateSerializer < ActiveModel::Serializer
  attributes  :created_at,
              :updated_at,
              :disabled,
              :name,
              :slug,
              :template,
              :title,
              :website_id,
              :web_layout_id

  def web_layout_id
    object.web_layout.id
  end
end
