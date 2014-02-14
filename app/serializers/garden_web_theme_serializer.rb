class GardenWebThemeSerializer < ActiveModel::Serializer
  attributes  :id,
              :name,
              :thumbnail,
              :url
end
