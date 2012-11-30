class Theme < ActiveRecord::Base
  THEME_GARDEN_URL = "http://g5-theme-garden.herokuapp.com"

  attr_accessible :name, :url, :stylesheets

  serialize :stylesheets, Array

  validates :url, presence: true

  def self.all_remote
    components = G5HentryConsumer::HG5Component.parse(THEME_GARDEN_URL)
    components.map do |component|
      new(
        name: component.name.first,
        url:  component.uid,
        stylesheets: component.stylesheets
      )
    end
  end
end
