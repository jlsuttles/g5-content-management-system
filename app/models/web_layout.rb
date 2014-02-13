class WebLayout < ActiveRecord::Base
  include HasManySettings

  # TODO: add to schema
  belongs_to :garden_web_layout
  belongs_to :web_template
  has_one :website, through: :web_template

  delegate :website_id,
    to: :web_template, allow_nil: true

  delegate :name, :url, :thumbnail, :html, :stylesheets,
    to: :garden_web_layout, allow_nil: true
end
