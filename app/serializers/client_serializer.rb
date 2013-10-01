class ClientSerializer < ActiveModel::Serializer
  attributes  :id,
              :urn,
              :name
end
