class WebsiteTemplateSerializer < ActiveModel::Serializer
  attributes  :created_at,
              :updated_at,
              :disabled,
              :name,
              :slug,
              :template,
              :title,
              :website_id
end
