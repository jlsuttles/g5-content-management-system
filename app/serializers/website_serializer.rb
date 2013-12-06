class WebsiteSerializer < ActiveModel::Serializer
  embed :ids, include: true

  has_one :website_template
  has_one :web_home_template
  has_many :web_page_templates

  attributes  :id,
              :location_id,
              :name,
              :slug,
              :custom_colors,
              :primary_color,
              :secondary_color,
              :heroku_url

  def heroku_url
    object.decorate.heroku_url
  end
end
