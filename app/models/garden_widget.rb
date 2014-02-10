class GardenWidget < ActiveRecord::Base
  attr_accessible :name, :url, :thumbnail, :edit_html, :edit_javascript,
    :show_html, :show_javascript, :lib_javascripts, :show_stylesheets, :settings

  serialize :lib_javascripts, :show_stylesheets, :settings
end
