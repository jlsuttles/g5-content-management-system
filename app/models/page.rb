class Page < ActiveRecord::Base
  attr_accessible :location_id, :name, :template, :slug, :title
  attr_accessible :widgets_attributes, :layout_attributes, :theme_attributes, :location_attributes

  belongs_to :location
  has_one :layout, class_name: "PageLayout"
  has_one :theme
  has_many :widgets, autosave: true, order: "position asc"
  
  accepts_nested_attributes_for :location
  accepts_nested_attributes_for :layout
  accepts_nested_attributes_for :theme
  accepts_nested_attributes_for :widgets, :allow_destroy => true

  validates :slug, :title, :name, presence: true
  validates :slug, :format => {with: /^[-_A-Za-z0-9]*$/, message: "can only contain letters, numbers, dashes, and underscores."}

  scope :home, where(name: "Home")
  
  def sections
    %w(main)
  end

  def all_widgets
    location.site_template.widgets + widgets
  end

  def mark_widgets_for_destruction
    widgets.each(&:mark_for_destruction)
  end

  def remote_widgets
    Widget.all_remote.delete_if {|widget| widgets.map(&:name).include? widget.name}
  end

  def stylesheets
    widgets.map(&:css).flatten + location.stylesheets
  end

  def javascripts
    widgets.map(&:javascript).flatten + location.javascripts
  end
  
  def compiled_file_path
    location.compiled_site_path + self.slug + '.html'
  end
  
end
