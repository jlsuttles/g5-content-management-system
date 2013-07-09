class RemoteWebThemeSerializer < ActiveModel::Serializer
  attributes  :name,
              :thumbnail,
              :url
end
