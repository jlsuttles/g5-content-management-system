class WebsiteTemplateSerializer < ActiveModel::Serializer
  attributes  :created_at,
              :updated_at,
              :html,
              :name,
              :stylesheets,
              :thumbnail,
              :url
end
