class Page < ActiveRecord::Base
  attr_accessible :location_id, :widgets_attributes, :name, :layout_attributes, :theme_attributes
  has_one :layout, class_name: "PageLayout"
  has_one :theme
  has_many :widgets, autosave: true, order: "position asc"
  accepts_nested_attributes_for :layout
  accepts_nested_attributes_for :theme
  accepts_nested_attributes_for :widgets, :allow_destroy => true
  belongs_to :location
  before_create :set_slug
  
  validates :name, presence: true
  
  def mark_widgets_for_destruction
    widgets.each(&:mark_for_destruction)
  end
  
  def remote_widgets
    Widget.all_remote.delete_if {|widget| widgets.map(&:name).include? widget.name}
  end
  
  private
  
  def set_slug
    self.slug = self.name.parameterize
  end
end
