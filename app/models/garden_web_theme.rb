class GardenWebTheme < ActiveRecord::Base
  attr_accessible :name, :url, :thumbnail, :javascripts, :stylesheets,
    :primary_color, :secondary_color
end
