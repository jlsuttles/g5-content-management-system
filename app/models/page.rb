class Page < ActiveRecord::Base
  attr_accessible :location_id, :widgets_attributes, :name, :layout_attributes, :theme_attributes
  has_one :layout, class_name: "PageLayout"
  has_one :theme
  has_many :widgets, order: "position asc"
  accepts_nested_attributes_for :layout
  accepts_nested_attributes_for :theme
  accepts_nested_attributes_for :widgets, :allow_destroy => true
  belongs_to :location
  
  validates :name, presence: true
  
end
