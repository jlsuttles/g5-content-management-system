class WebsiteSerializer < ActiveModel::Serializer
  embed :ids, include: true

  has_one :website_template
  has_many :web_page_templates

  attributes  :id,
              :name,
              :custom_colors,
              :primary_color,
              :secondary_color
end
