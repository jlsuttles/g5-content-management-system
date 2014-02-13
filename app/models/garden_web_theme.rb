class GardenWebTheme < ActiveRecord::Base
  include ComponentGardenable

  set_garden_url ENV["THEME_GARDEN_URL"]

  attr_accessible :name, :url, :thumbnail, :javascripts, :stylesheets,
    :primary_color, :secondary_color

  serialize :stylesheets, Array
  serialize :javascripts, Array

  has_many :web_themes, dependent: :destroy

  validates :name, presence: true
  validates :url, presence: true
  validates :thumbnail, presence: true

  def in_use?
    web_themes.present?
  end
end
