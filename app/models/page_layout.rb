class PageLayout < ActiveRecord::Base
  LAYOUT_GARDEN_URL = "http://g5-layout-garden.herokuapp.com/"

  attr_accessible :page_id, :url, :name, :html

  belongs_to :page

  before_create :assign_attributes_from_url

  validates :url, presence: true

  def self.all_remote
    components = G5HentryConsumer::HG5Component.parse(LAYOUT_GARDEN_URL)
    components.map do |component|
      new(url: component.uid, name: component.name.first)
    end
  end

  private

  def assign_attributes_from_url
    component = G5HentryConsumer::HG5Component.parse(url).first
    if component
      self.name = component.name.first
      self.html = component.content.first
      true
    else
      raise "No h-g5-component found at url: #{url}"
    end
  rescue OpenURI::HTTPError => e
    logger.warn e.message
  end
end
