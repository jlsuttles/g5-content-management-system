class GardenWidget < ActiveRecord::Base
  attr_accessible :name, :url, :thumbnail, :edit_html, :edit_javascript,
    :show_html, :show_javascript, :lib_javascripts, :show_stylesheets, :settings

  serialize :lib_javascripts, Array
  serialize :show_stylesheets, Array
  serialize :settings, Array

  has_many :widgets, dependent: :destroy

  validates :name, presence: true
  validates :url, presence: true
  validates :thumbail, presence: true
  validates :edit_html, presence: true
  validates :show_html, presence: true
end
