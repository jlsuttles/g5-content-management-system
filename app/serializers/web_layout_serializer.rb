class WebLayoutSerializer < ActiveModel::Serializer
  attributes  :name,
              :thumbnail,
              :url,
              :web_template_id
end
