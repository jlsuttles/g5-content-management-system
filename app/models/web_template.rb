class WebTemplate < ActiveRecord::Base
  attr_accessible :website_id,
                  :name,
                  :template,
                  :slug,
                  :title,
                  :disabled,
                  :widgets_attributes,
                  :web_layout_attributes,
                  :web_theme_attributes,
                  :website_attributes

  belongs_to :website
  has_one :web_layout, dependent: :destroy
  has_one :web_theme, dependent: :destroy
  has_many :widgets, autosave: true, dependent: :destroy, order: "position asc"

  accepts_nested_attributes_for :website
  accepts_nested_attributes_for :web_layout
  accepts_nested_attributes_for :web_theme
  accepts_nested_attributes_for :widgets, :allow_destroy => true

  validates :slug, :title, :name, presence: true
  validates :slug, :format => {with: /^[-_A-Za-z0-9]*$/, message: "can only contain letters, numbers, dashes, and underscores."}

  scope :home, where(name: "Home")
  scope :enabled, where(disabled: false)
  scope :disabled, where(disabled: true)

  after_initialize :default_enabled_to_true

  def sections
    %w(main)
  end

  def all_widgets
    website.website_template.widgets + widgets
  end

  def remote_widgets
    Widget.all_remote.delete_if {|widget| widgets.map(&:name).include? widget.name}
  end

  def compiled_stylesheets
    stylesheets.map do |stylesheet|
      remote_stylesheet = RemoteStylesheet.new(
       stylesheet,
       { primary: website.primary_color,
         secondary: website.secondary_color }
      )
      remote_stylesheet.compile
      remote_stylesheet.css_link_path
    end
  end

  def stylesheets
    widgets.map(&:stylesheets).flatten + website.website_template.stylesheets
  end

  def javascripts
    widgets.map(&:javascripts).flatten + website.website_template.javascripts
  end

  def compiled_file_path
    File.join(website.compiled_site_path, "#{self.slug}.html")
  end

  private

  def default_enabled_to_true
    self.disabled ||= false
  end

end
