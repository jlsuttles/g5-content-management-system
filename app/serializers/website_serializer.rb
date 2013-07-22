class WebsiteSerializer < ActiveModel::Serializer
  attributes  :id,
              :urn,
              :custom_colors,
              :primary_color,
              :secondary_color
end
