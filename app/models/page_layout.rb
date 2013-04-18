class PageLayout < ActiveRecord::Base
  attr_accessible :page_id, :url, :name, :html, :thumbnail, :stylesheets

  belongs_to :page

  serialize :stylesheets, Array
  after_initialize :set_default_stylesheets

  before_save :assign_attributes_from_url

  validates :url, presence: true

  def self.garden_url
    ENV["LAYOUT_GARDEN_URL"]
  end

  def self.all_remote
    components = Microformats2.parse(garden_url).g5_components
    components.map do |component|
      new(
        url: component.uid.to_s,
        name: component.name.to_s,
        thumbnail: component.photo.to_s
      )
    end
  end

  private

  def assign_attributes_from_url
    component = Microformats2.parse(url).first
    if component
      self.name        = component.name.to_s
      self.stylesheets = (component.g5_stylesheets.try(:map) {|s|s.to_s} if component.respond_to?(:g5_stylesheets))
      self.html        = CGI.unescapeHTML(component.content.to_s)
      self.thumbnail   = component.photo.to_s
      true
    else
      raise "No h-g5-component found at url: #{url}"
    end
  rescue OpenURI::HTTPError => e
    logger.warn e.message
  end

  def set_default_stylesheets
    self.stylesheets ||= []
  end
end
