class GardenWebTheme < ActiveRecord::Base
  attr_accessible :name, :url, :thumbnail, :javascripts, :stylesheets,
    :primary_color, :secondary_color

  serialize :stylesheets, Array
  serialize :javascripts, Array

  has_many :web_themes, dependent: :destroy

  validates :name, presence: true
  validates :url, presence: true
  validates :thumbail, presence: true
end
