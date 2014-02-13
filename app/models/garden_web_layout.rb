class GardenWebLayout < ActiveRecord::Base
  include ComponentGardenable

  set_garden_url ENV["LAYOUT_GARDEN_URL"]

  attr_accessible :name, :url, :thumbnail, :html, :stylesheets

  serialize :stylesheets, Array

  # TODO: do not destroy if in use
  has_many :garden_web_layouts, dependent: :destroy

  after_initialize :set_default_stylesheets

  validates :name, presence: true
  validates :url, presence: true
  validates :thumbail, presence: true
  validates :html, presence: true

  private

  def set_default_stylesheets
    self.stylesheets ||= []
  end
end
