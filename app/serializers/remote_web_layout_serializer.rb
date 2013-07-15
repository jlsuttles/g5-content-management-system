class RemoteWebLayoutSerializer < ActiveModel::Serializer
  attributes  :name,
              :thumbnail,
              :url
end
