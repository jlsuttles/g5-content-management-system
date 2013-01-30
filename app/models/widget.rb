class Widget < ActiveRecord::Base
  WIDGET_GARDEN_URL = "http://g5-widget-garden.herokuapp.com"

  attr_accessible :page_id, :section, :position, :url, :name, :stylesheets, :javascripts, :html, :thumbnail, :edit_form_html

  serialize :stylesheets, Array
  serialize :javascripts, Array

  belongs_to :page

  before_create :assign_attributes_from_url

  validates :url, presence: true

  scope :in_section, lambda { |section| where(section: section) }

  def self.all_remote
    components = G5HentryConsumer::HG5Component.parse(WIDGET_GARDEN_URL)
    components.map do |component|
      puts component.edit_template.inspect
      new(url: component.uid, name: component.name.first, thumbnail: component.thumbnail.first)
    end
  end
  
  def update_configuration(params)
    # SHOULD UPDATE CONFIGURATIONS DEFINED BY WIDGET GARDEN
    true
  end
  
  private

  def assign_attributes_from_url
    component = G5HentryConsumer::HG5Component.parse(url).first
    puts component.edit_template.inspect
    if component
      self.name           = component.name.first
      self.stylesheets    = component.stylesheets
      self.javascripts    = component.javascripts
      # TEMPORARY - CHANGE WITH HTML RETURNED FROM WIDGET GARDEN
      self.edit_form_html = open(component.edit_template.first).read
      self.html           = component.content.first
      self.thumbnail      = component.thumbnail.first
      true
    else
      raise "No h-g5-component found at url: #{url}"
    end
  rescue OpenURI::HTTPError => e
    logger.warn e.message
  end
end
