class WebThemeSerializer < ActiveModel::Serializer
  attributes  :created_at,
              :updated_at,
              :colors,
              :name,
              :stylesheets,
              :javascripts,
              :thumbnail,
              :url
end
