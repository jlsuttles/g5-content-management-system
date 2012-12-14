class Widget < ActiveRecord::Base
  WIDGET_GARDEN_URL = "http://g5-widget-garden.herokuapp.com"

  attr_accessible :page_id, :section, :position, :url, :name, :css, :javascript, :html, :thumbnail

  serialize :css, Array
  serialize :javascript, Array

  belongs_to :page

  before_create :assign_attributes_from_url

  validates :url, presence: true

  scope :in_section, lambda { |section| where(section: section) }

  def self.all_remote
    components = G5HentryConsumer::HG5Component.parse(WIDGET_GARDEN_URL)
    components.map do |component|
      new(url: component.uid, name: component.name.first, thumbnail: component.thumbnail.first)
    end
  end

  private

  def assign_attributes_from_url
    component = G5HentryConsumer::HG5Component.parse(url).first
    if component
      self.name       = component.name.first
      self.css        = component.stylesheets
      self.javascript = component.javascripts
      self.html       = component.content.first
      true
    else
      raise "No h-g5-component found at url: #{url}"
    end
  rescue OpenURI::HTTPError => e
    logger.warn e.message
  end
end
