class Theme < ActiveRecord::Base
  THEME_GARDEN_URL = "http://g5-theme-garden.herokuapp.com"

  attr_accessible :page_id, :url, :name, :stylesheets, :thumbnail

  serialize :stylesheets, Array

  belongs_to :page

  validates :url, presence: true

  def self.all_remote
    components = G5HentryConsumer::HG5Component.parse(THEME_GARDEN_URL)
    components.map do |component|
      new(
        url:  component.uid,
        name: component.name.first
      )
    end
  end
end
