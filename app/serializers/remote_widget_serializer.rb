class RemoteWidgetSerializer < ActiveModel::Serializer
  attributes  :name,
              :thumbnail,
              :url
end
