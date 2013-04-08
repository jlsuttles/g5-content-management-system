class WebTemplate < ActiveRecord::Base
  include PrioritizedSettings

  attr_accessible :website_id,
                  :name,
                  :title,
                  :disabled,
                  :slug,
                  :website_attributes,
                  :web_layout_attributes,
                  :web_theme_attributes,
                  :widgets_attributes

  belongs_to :website

  has_one :web_layout , autosave: true , dependent: :destroy
  has_one :web_theme  , autosave: true , dependent: :destroy
  # TODO: has_many :widgets, through: :drop_areas
  has_many :widgets   , autosave: true , dependent: :destroy , order: "position asc"

  accepts_nested_attributes_for :website
  accepts_nested_attributes_for :web_layout , allow_destroy: true
  accepts_nested_attributes_for :web_theme  , allow_destroy: true
  accepts_nested_attributes_for :widgets    , allow_destroy: true

  validates :title , presence: true
  validates :name  , presence: true
  validates :slug  , presence: true ,
    format: {
      with: /^[-_A-Za-z0-9]*$/,
      message: "can only contain letters, numbers, dashes, and underscores."
    }

  scope :home, where(name: "Home")
  scope :enabled, where(disabled: false)
  scope :disabled, where(disabled: true)

  after_initialize :default_enabled_to_true

  before_validation :parameterize_title_to_slug, if: :title_changed?

  def sections
    %w(main)
  end

  def all_widgets
    website.website_template.widgets + widgets
  end

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
    widgets.map(&:javascripts).flatten +
    website.try(:website_template).try(:javascripts).to_a
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

  def default_enabled_to_true
    self.disabled ||= false
  end

  def parameterize_title_to_slug
    self.slug = title.parameterize
  end
end
