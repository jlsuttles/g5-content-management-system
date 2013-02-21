class WidgetAttribute < ActiveRecord::Base
  attr_accessible :default_value, :editable, :name, :value
  liquid_methods :name, :default_value, :id, :value
end
