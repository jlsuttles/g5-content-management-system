class ClientSerializer < ActiveModel::Serializer
  embed :ids, include: true

  has_many :locations

  attributes  :id,
              :urn,
              :name
end
