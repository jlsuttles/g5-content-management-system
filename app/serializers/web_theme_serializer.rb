class WebThemeSerializer < ActiveModel::Serializer
  attributes  :id,
              :website_template_id,
              :name,
              :thumbnail,
              :url,
              :custom_colors,
              :primary_color,
              :secondary_color
end
