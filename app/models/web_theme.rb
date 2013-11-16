class WebTheme < ActiveRecord::Base
  include ComponentGardenable
  include HasManySettings

  set_garden_url ENV["THEME_GARDEN_URL"]

  serialize :stylesheets, Array
  serialize :javascripts, Array
  serialize :colors, Array

  belongs_to :web_template
  has_one :website, through: :web_template

  before_save :assign_attributes_from_url

  validates :url, presence: true

  def website_id
    web_template.website_id if web_template
  end

  def website_template
    web_template
  end

  def website_template_id
    web_template_id
  end

  def display_colors
    { primary_color: primary_color,
      secondary_color: secondary_color }
  end

  def primary_color
    if custom_colors? && custom_primary_color
      custom_primary_color
    else
      colors[0]
    end
  end

  def primary_color=(value)
    self.custom_primary_color = value
  end

  def secondary_color
    if custom_colors? && custom_secondary_color
      custom_secondary_color
    else
      colors[1]
    end
  end

  def secondary_color=(value)
    self.custom_secondary_color = value
  end

  private

  def assign_attributes_from_url
    component = Microformats2.parse(url).first
    if component
      self.name        = component.name.to_s
      self.stylesheets = component.g5_stylesheets.try(:map) {|s|s.to_s} if component.respond_to?(:g5_stylesheets)
      self.javascripts = component.g5_javascripts.try(:map) {|j|j.to_s} if component.respond_to?(:g5_javascripts)
      self.thumbnail   = component.photo.to_s                           if component.respond_to?(:photo)
      self.colors      = component.g5_colors.try(:map) {|c|c.to_s}      if component.respond_to?(:g5_colors)
      true
    else
      raise "No h-g5-component found at url: #{url}"
    end
  rescue OpenURI::HTTPError => e
    Rails.logger.warn e.message
  end
end
