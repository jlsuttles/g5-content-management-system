class Theme < ActiveRecord::Base
  THEME_GARDEN_URL = "http://g5-theme-garden.herokuapp.com"

  attr_accessible :page_id, :url, :name, :stylesheets, :javascripts, :thumbnail, :colors

  serialize :stylesheets, Array
  serialize :javascripts, Array
  serialize :colors, Array

  belongs_to :page

  before_save :assign_attributes_from_url

  validates :url, presence: true

  def self.all_remote
    components = Microformats2.parse(THEME_GARDEN_URL).g5_components
    components.map do |component|
      new(url: component.uid.to_s, name: component.name.to_s, thumbnail: component.photo.to_s)
    end
  end

  def primary_color
    colors[0]
  end

  def secondary_color
    colors[1]
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
    logger.warn e.message
  end
end
