class WebLayout < ActiveRecord::Base
  include ComponentGardenable
  include HasManySettings

  set_garden_url ENV["LAYOUT_GARDEN_URL"]

  attr_accessible :web_template_id,
                  :web_template_type,
                  :url,
                  :name,
                  :html,
                  :thumbnail,
                  :stylesheets

  belongs_to :web_template, polymorphic: true

  serialize :stylesheets, Array
  after_initialize :set_default_stylesheets

  before_save :assign_attributes_from_url

  validates :url, presence: true

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