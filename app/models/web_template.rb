class WebTemplate < ActiveRecord::Base
  include RankedModel
  include HasManySettings
  include AfterUpdateSetSettingNavigation

  ranks :display_order, with_same: :website_id

  belongs_to :website
  has_one :website_template, through: :website
  has_one :website_layout, through: :website_template, source: :web_layout

  has_one :web_layout , autosave: true , dependent: :destroy
  has_one :web_theme  , autosave: true , dependent: :destroy

  has_many :drop_targets, autosave: true, dependent: :destroy
  has_many :widgets, through: :drop_targets, order: "display_order ASC"

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

  before_validation :default_title_from_name
  before_validation :default_slug_from_title

  # TODO: remove when Ember App implements DropTarget
  def main_widgets
    drop_targets.where(html_id: "drop-target-main").first.try(:widgets)
  end

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

  def website_compile_path
    website.compile_path if website
  end

  def website_colors
    website.colors if website
  end

  def compile_path
    File.join(website_compile_path.to_s, "#{slug}.html")
  end

  def stylesheets_compiler
    @stylesheets_compiler ||= StaticWebsite::Compiler::Stylesheets.new(stylesheets, "#{Rails.root}/public", website_colors)
  end

  def stylesheet_link_paths
    stylesheets_compiler.compile
    stylesheets_compiler.link_paths
  end

  private

  def default_title_from_name
    self.title ||= name
  end

  def default_slug_from_title
    self.slug ||= title.parameterize
  end
end
