class GardenWebLayout < ActiveRecord::Base
  include ComponentGardenable

  set_garden_url ENV["LAYOUT_GARDEN_URL"]

  serialize :stylesheets, Array

  has_many :web_layouts, dependent: :destroy

  after_initialize :set_default_stylesheets

  validates :name, presence: true
  validates :slug, presence: true
  validates :url, presence: true
  validates :thumbnail, presence: true
  validates :html, presence: true

  def in_use?
    web_layouts.present?
  end

  private

  def set_default_stylesheets
    self.stylesheets ||= []
  end
end
