class WebsiteSerializer < ActiveModel::Serializer
  embed :ids, include: true

  has_one :website_template

  attributes  :id,
              :urn,
              :custom_colors,
              :primary_color,
              :secondary_color
end
