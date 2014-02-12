class WebTheme < ActiveRecord::Base
  include ComponentGardenable
  include HasManySettings

  set_garden_url ENV["THEME_GARDEN_URL"]

  # TODO: add to schema
  belongs_to :garden_web_theme
  belongs_to :web_template
  has_one :website, through: :web_template

  alias_method :website_template, :web_template
  alias_method :website_template_id, :web_template_id

  delegate :website_id,
    to: :web_template, allow_nil: true

  delegate :name, :url, :thumbnail, :javascripts, :stylesheets,
    to: :garden_web_theme, allow_nil: true

  def display_colors
    { primary_color: primary_color,
      secondary_color: secondary_color }
  end

  def primary_color
    if custom_colors? && custom_primary_color
      custom_primary_color
    else
      garden_web_theme.try(:primary_color)
    end
  end

  def primary_color=(value)
    self.custom_primary_color = value
  end

  def secondary_color
    if custom_colors? && custom_secondary_color
      custom_secondary_color
    else
      garden_web_theme.try(:secondary_color)
    end
  end

  def secondary_color=(value)
    self.custom_secondary_color = value
  end
end
