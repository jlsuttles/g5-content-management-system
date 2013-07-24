class WebLayoutSerializer < ActiveModel::Serializer
  attributes  :id,
              :website_template_id,
              :name,
              :thumbnail,
              :url
end
