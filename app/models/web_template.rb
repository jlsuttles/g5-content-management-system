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
  has_many :widgets, -> { order("display_order ASC") }, through: :drop_targets

  delegate :application_min_css_path, :application_min_js_path,
    to: :website, allow_nil: true

  validates :title , presence: true
  validates :name  , presence: true
  validates :slug  , presence: true ,
    format: {
      with: /\A[-_A-Za-z0-9]*\z/,
      message: "can only contain letters, numbers, dashes, and underscores."
    },
    unless: :new_record?

  scope :home, -> { where(name: "Home") }
  scope :enabled, -> { where(enabled: true) }
  scope :disabled, -> { where(enabled: false) }
  scope :trash, -> { where(in_trash: true) }
  scope :not_trash, -> { where(in_trash: false) }
  scope :navigateable, -> { not_trash.enabled.where("type != ?", "WebsiteTemplate") }
  scope :created_at_asc, -> { order("created_at ASC") }

  before_validation :default_enabled_to_true
  before_validation :default_in_trash_to_false
  before_validation :default_title_from_name
  before_validation :default_slug_from_title

  before_save :format_redirect_patterns

  # TODO: remove when Ember App implements DropTarget
  def main_widgets
    drop_targets.where(html_id: "drop-target-main").first.try(:widgets)
  end

  def meta_description_widgets
    widgets.meta_description
  end

  def client
    Client.first
  end

  def location
    website.try(:location)
  end

  def location_id
    location.try(:id)
  end

  def location_name
    location.try(:name)
  end

  def vertical
    client.try(:vertical_slug)
  end

  def city
    location.try(:city_slug)
  end

  def state
    location.try(:state_slug)
  end

  def url
    if web_home_template?
      "/"
    else
      "/#{vertical}/#{state}/#{city}/#{slug}/"
    end
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

  def web_page_template?
    type == "WebPageTemplate"
  end

  def stylesheets
    widgets.map(&:show_stylesheets).flatten +
    website.try(:website_template).try(:stylesheets).to_a
  end

  def javascripts
    widget_lib_javascripts + widgets.map(&:show_javascript).flatten.compact +
    website.try(:website_template).try(:javascripts).to_a.flatten.compact
  end

  def widget_lib_javascripts
    widgets.map(&:lib_javascripts).flatten.compact +
    website.try(:website_template).try(:widget_lib_javascripts).to_a.flatten.compact
  end

  def website_compile_path
    website.compile_path if website
  end

  def website_colors
    website.colors if website
  end

  def stylesheets_compiler
    @stylesheets_compiler ||=
      StaticWebsite::Compiler::Stylesheets.new(stylesheets,
      "#{Rails.root}/public", website_colors, location_name, true)
  end

  def stylesheet_link_paths
    stylesheets_compiler.compile
    stylesheets_compiler.link_paths
  end

  def javascripts_compiler
    @javascripts_compiler ||=
      StaticWebsite::Compiler::Javascripts.new(javascripts,
        "#{Rails.root}/public", location_name)
  end

  def javascript_include_paths
    javascripts_compiler.compile
    javascripts_compiler.uploaded_paths
  end


  def location_domain
    location.domain if location
  end

  def page_url
    File.join(location_domain.to_s, relative_path.to_s)
  end

  def last_mod
    widgets.order("updated_at").last.updated_at.to_date
  end

  private

  def default_enabled_to_true
    # ||= does not work here because enabled is a boolean
    self.enabled = true if enabled.nil?
  end

  def default_in_trash_to_false
    # ||= does not work here because in_trash is a boolean
    self.in_trash = false if in_trash.nil?
    # return true to continue validation
    true
  end

  def default_title_from_name
    self.title ||= name
  end

  def default_slug_from_title
    self.slug ||= title.parameterize
  end

  def format_redirect_patterns
    self.redirect_patterns = redirect_patterns.split.uniq.join("\n") if redirect_patterns
  end
end
