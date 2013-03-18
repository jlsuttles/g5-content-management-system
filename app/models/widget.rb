class Widget < ActiveRecord::Base
  include AssociationToMethod

  #TODO remove this if location will not have a concept of address
  liquid_methods :location

  WIDGET_GARDEN_URL = "http://g5-widget-garden.herokuapp.com"

  attr_accessible :page_id, :section, :position, :url, :name, :stylesheets,
                  :javascripts, :html, :thumbnail, :edit_form_html,
                  :widget_attributes_attributes

  serialize :stylesheets, Array
  serialize :javascripts, Array

  belongs_to :page
  has_one :location, :through => :page
  has_many :settings, as: :component, after_add: :define_dynamic_association_method
  has_many :widget_attributes, through: :settings

  accepts_nested_attributes_for :widget_attributes

  alias_attribute :dynamic_association, :settings

  before_create :assign_attributes_from_url

  validates :url, presence: true

  scope :in_section, lambda { |section| where(section: section) }

  def self.all_remote
    components = Microformats2.parse(WIDGET_GARDEN_URL).g5_components
    components.map do |component|
      new(url: component.uid.to_s, name: component.name.to_s, thumbnail: component.photo.to_s)
    end
  end

  def liquidized_html
    Liquid::Template.parse(CGI::unescape(self.html)).render("widget" => self)
  end

  def kind_of_widget?(kind)
    name == kind
  end

  private

  def assign_attributes_from_url
    component = Microformats2.parse(url).g5_components.first
    if component
      self.name        = component.name.to_s
      self.stylesheets = component.g5_stylesheets.try(:map) {|s|s.to_s} if component.respond_to?(:g5_stylesheets)
      self.javascripts = component.g5_javascripts.try(:map) {|j|j.to_s} if component.respond_to?(:g5_javascripts)
      self.edit_form_html = get_edit_form_html(component)
      self.html           = component.content.to_s
      self.thumbnail      = component.photo.to_s
      parse_settings(component.g5_property_groups)
      true
    else
      raise "No h-g5-component found at url: #{url}"
    end
  rescue OpenURI::HTTPError => e
    logger.warn e.message
  end

  def parse_settings(property_groups)
    return if property_groups.blank?
    property_groups.each do |property_group|
      property_group = property_group.format
      setting = self.settings.build(name: property_group.name.to_s,
                                    categories: property_group.categories.map{|c|c.to_s})
      property_group.g5_properties.each do |property|
        property = property.format
        setting.widget_attributes.build(name: property.g5_name.to_s, editable: property.g5_editable.to_s || false, default_value: property.g5_default_value.to_s)
      end
    end
  end

  def get_edit_form_html(component)
    url = component.g5_edit_template.to_s
    open(url).read if url
  end

end
