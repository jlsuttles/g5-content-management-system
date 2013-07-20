class LocationSerializer < ActiveModel::Serializer
  attributes  :id,
              :urn,
              :web_home_template_id,
              :website_id

  def web_home_template_id
    object.web_home_template.id
  end

  def website_id
    object.website.id
  end
end
