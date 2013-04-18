class Page < ActiveRecord::Base
  attr_accessible :location_id, :name, :template, :slug, :title, :disabled
  attr_accessible :widgets_attributes, :page_layout_attributes, :theme_attributes, :location_attributes

  belongs_to :location
  has_one :page_layout
  has_one :theme
  has_many :widgets, autosave: true, order: "position asc"

  accepts_nested_attributes_for :location
  accepts_nested_attributes_for :page_layout
  accepts_nested_attributes_for :theme
  accepts_nested_attributes_for :widgets, :allow_destroy => true

  validates :slug, :title, :name, presence: true
  validates :slug, :format => {with: /^[-_A-Za-z0-9]*$/, message: "can only contain letters, numbers, dashes, and underscores."}

  scope :home, where(name: "Home")
  scope :enabled, where(disabled: false)
  scope :disabled, where(disabled: true)

  def sections
    %w(main)
  end

  def all_widgets
    location.site_template.widgets + widgets
  end

  def remote_widgets
    Widget.all_remote.delete_if {|widget| widgets.map(&:name).include? widget.name}
  end

  def compiled_stylesheets
    stylesheets.map do |stylesheet|
      remote_stylesheet = RemoteStylesheet.new(
       stylesheet,
       { primary: location.primary_color,
         secondary: location.secondary_color }
      )
      remote_stylesheet.compile
      remote_stylesheet.css_link_path
    end
  end

  def stylesheets
    widgets.map(&:stylesheets).flatten + location.site_template.stylesheets
  end

  def javascripts
    widgets.map(&:javascripts).flatten + location.site_template.javascripts
  end

  def compiled_file_path
    File.join(location.compiled_site_path, "#{self.slug}.html")
  end

end
