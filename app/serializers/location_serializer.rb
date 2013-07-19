class LocationSerializer < ActiveModel::Serializer
  attributes  :id,
              :urn,
              :web_home_template_id

  def web_home_template_id
    object.web_home_template.id
  end
end
