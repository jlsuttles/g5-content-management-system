class WebLayoutSerializer < ActiveModel::Serializer
  attributes  :created_at,
              :updated_at,
              :html,
              :name,
              :stylesheets,
              :thumbnail,
              :url,
              :web_template_id
end
