require_dependency 'liquid_filters'

class Widget < ActiveRecord::Base
  include AssociationToMethod

  liquid_methods :location

  attr_accessible :page_id, :section, :position, :url, :name, :stylesheets,
                  :javascripts, :html, :thumbnail, :edit_form_html,
                  :properties_attributes

  serialize :stylesheets, Array
  serialize :javascripts, Array

  belongs_to :page
  has_one :location, :through => :page
  has_many :property_groups, as: :component, after_add: :define_dynamic_association_method
  has_many :properties, through: :property_groups

  has_many :widget_entries, dependent: :destroy

  accepts_nested_attributes_for :properties

  alias_attribute :dynamic_association, :property_groups

  before_create :assign_attributes_from_url

  validates :url, presence: true

  scope :in_section, lambda { |section| where(section: section) }
  scope :name_like_form, where("widgets.name LIKE '%Form'")

  def self.all_remote
    components = Microformats2.parse(ENV['WIDGET_GARDEN_URL']).g5_components
    components.map do |component|
      new(url: component.uid.to_s, name: component.name.to_s, thumbnail: component.photo.to_s)
    end
  end

  def liquidized_html
    Liquid::Template.parse(self.html).render({'widget' => self}, filters: [UrlEncode])
  end

  def kind_of_widget?(kind)
    name == kind
  end

  def create_widget_entry_if_updated
    widget_entries.create if updated_since_last_widget_entry
  end

  def updated_since_last_widget_entry
    return true if widget_entries.blank?
    updated_at > widget_entries.maximum(:updated_at)
  end

  private

  def assign_attributes_from_url
    component = Microformats2.parse(url).g5_components.first
    if component
      self.name        = component.name.to_s
      self.stylesheets = component.g5_stylesheets.try(:map) {|s|s.to_s} if component.respond_to?(:g5_stylesheets)
      self.javascripts = component.g5_javascripts.try(:map) {|j|j.to_s} if component.respond_to?(:g5_javascripts)
      self.edit_form_html = get_edit_form_html(component)
      self.html           = get_show_html(component)
      self.thumbnail      = component.photo.to_s
      build_property_groups_from_microformats(component.g5_property_groups)
      true
    else
      raise "No h-g5-component found at url: #{url}"
    end
  rescue OpenURI::HTTPError => e
    logger.warn e.message
  end

  def build_property_groups_from_microformats(e_property_groups)
    return if e_property_groups.blank?
    # build property groups
    e_property_groups.each do |e_property_group|
      h_property_group = e_property_group.format
      property_group = self.property_groups.build(
        name: h_property_group.name.to_s,
        categories: h_property_group.categories.map{|c|c.to_s}
      )
      # build properties for each property group
      h_property_group.g5_properties.each do |e_property|
        h_property = e_property.format
        property_group.properties.build(
          name: h_property.g5_name.to_s,
          editable: h_property.g5_editable.to_s || false,
          default_value: h_property.g5_default_value.to_s
        )
      end
    end
  end

  def get_edit_form_html(component)
    url = component.g5_edit_template.to_s
    open(url).read if url
  end

  def get_show_html(component)
    url = component.g5_show_template.to_s
    open(url).read if url
  end

end

