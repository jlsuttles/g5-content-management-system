class Widget < ActiveRecord::Base
  WIDGET_GARDEN_URL = "http://g5-widget-garden.herokuapp.com"

  attr_accessible :page_id, :section, :position, :url, :name, :css, :javascript, :html

  serialize :css, Array
  serialize :javascript, Array

  belongs_to :page

  validates :name, :url, presence: true

  scope :in_section, lambda { |section| where(section: section) }

  def self.all_remote
    components = G5HentryConsumer::HG5Component.parse(WIDGET_GARDEN_URL)
    components.map do |component|
      new(
        url:        component.uid,
        name:       component.name.first,
        css:        component.stylesheets,
        javascript: component.javascripts,
        html:       component.content.first
      )
    end
  end
end
