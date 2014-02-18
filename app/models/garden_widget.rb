class GardenWidget < ActiveRecord::Base
  include ComponentGardenable

  set_garden_url ENV["WIDGET_GARDEN_URL"]

  attr_accessible :name, :slug, :url, :thumbnail, :edit_html, :edit_javascript,
    :show_html, :show_javascript, :lib_javascripts, :show_stylesheets, :settings

  serialize :lib_javascripts, Array
  serialize :show_stylesheets, Array
  serialize :settings, Array

  has_many :widgets, autosave: true, dependent: :destroy

  validates :name, presence: true
  validates :slug, presence: true
  validates :url, presence: true
  validates :thumbnail, presence: true
  validates :edit_html, presence: true
  validates :show_html, presence: true

  def update_widgets_settings(new_settings=settings)
    widgets.map { |widget| widget.update_settings(new_settings) }
  end
end
