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
      new(url: component.uid, name: component.name.first, thumbnail: component.thumbnail.first)
    end
  end
  
  def update_configuration(params)
    # SHOULD UPDATE CONFIGURATIONS DEFINED BY WIDGET GARDEN
    self.valid?
  end
  
  private

  def assign_attributes_from_url
    component = G5HentryConsumer::HG5Component.parse(url).first
    if component
      self.name           = component.name.first
      self.stylesheets    = component.stylesheets
      self.javascripts    = component.javascripts
      # TEMPORARY - CHANGE WITH HTML RETURNED FROM WIDGET GARDEN
      self.edit_form_html = '<form action="/widgets/{{ widget.id }}"> <div style="margin:0;padding:0;display:inline"> <input name="_method" type="hidden" value="put"> </div><input type="submit" value="Save" /><div class="field"> <label>Enter Twitter username</label> <input type="text" name="widget[username]" placeholder="@username" /> </div></form>'
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
