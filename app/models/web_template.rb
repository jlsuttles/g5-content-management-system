class WebTemplate < ActiveRecord::Base
  include HasManySettings
  include AfterUpdateSetSettingNavigation

  belongs_to :website

  has_one :web_layout , autosave: true , dependent: :destroy
  has_one :web_theme  , autosave: true , dependent: :destroy
  # TODO: has_many :widgets, through: :drop_areas
  has_many :widgets   , autosave: true , dependent: :destroy , order: "position asc"

  validates :title , presence: true
  validates :name  , presence: true
  validates :slug  , presence: true ,
    format: {
      with: /^[-_A-Za-z0-9]*$/,
      message: "can only contain letters, numbers, dashes, and underscores."
    },
    unless: :new_record?

  scope :home, where(name: "Home")
  scope :enabled, where(disabled: false)
  scope :disabled, where(disabled: true)
  scope :navigateable, where("type != ?", "WebsiteTemplate")
  scope :created_at_asc, order("created_at ASC")

  after_initialize :assign_defaults
  before_validation :parameterize_title_to_slug

  def location
    website.try(:location)
  end

  def location_id
    location.try(:id)
  end

  def website_id
    website.try(:id)
  end

  def web_layout_id
    web_layout.try(:id)
  end

  def web_theme_id
    web_theme.try(:id)
  end

  def web_home_template?
    type == "WebHomeTemplate"
  end

  # is this used anywhere?
  def remote_widgets
    Widget.all_remote.delete_if do |widget|
      widgets.map(&:name).include? widget.name
    end
  end

  def stylesheets
    widgets.map(&:stylesheets).flatten +
    website.try(:website_template).try(:stylesheets).to_a
  end

  def javascripts
    widget_lib_javascripts + widgets.map(&:show_javascript).flatten.compact +
    website.try(:website_template).try(:javascripts).to_a.flatten.compact
  end

  def widget_lib_javascripts
    widgets.map(&:lib_javascripts).flatten +
    website.try(:website_template).try(:widget_lib_javascripts).to_a
  end

  def compile_path
    File.join(website.try(:compile_path).to_s, "#{slug}.html")
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

  private

  def assign_defaults
    self.name  ||= "Web Template"
    self.title ||= name
    self.slug  ||= name.parameterize
    self.disabled ||= false
  end

  def parameterize_title_to_slug
    self.slug ||= title.parameterize
  end
end
