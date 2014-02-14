class GardenWebLayoutSerializer < ActiveModel::Serializer
  attributes  :id,
              :name,
              :thumbnail,
              :url
end
