class PageLayout < ActiveRecord::Base
  LAYOUT_GARDEN_URL = "http://g5-layout-garden.herokuapp.com/"

  attr_accessible :html, :name, :page_id, :url

  validates :url, presence: true

  def self.all_remote
    components = G5HentryConsumer::HG5Component.parse(LAYOUT_GARDEN_URL)
    components.map do |component|
      new(
        name: component.name.first,
        url:  component.uid,
        html: component.content.first
      )
    end
  end
end
