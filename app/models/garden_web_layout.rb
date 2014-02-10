class GardenWebLayout < ActiveRecord::Base
  attr_accessible :name, :url, :thumbnail, :html, :stylesheets
end
