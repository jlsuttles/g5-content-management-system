require_dependency 'liquid_filters'

class Widget < ActiveRecord::Base
  include HasManySettings
  include ComponentGardenable

  attr_accessible :web_template_id,
                  :web_template_type,
                  :section,
                  :position,
                  :url,
                  :name,
                  :stylesheets,
                  :javascripts,
                  :html,
                  :thumbnail,
                  :edit_form_html,
                  :settings_attributes

  serialize :stylesheets, Array
  serialize :javascripts, Array

  belongs_to :web_template, polymorphic: true
  has_one :location, through: :web_template

  has_many :widget_entries, dependent: :destroy

  before_create :assign_attributes_from_url

  validates :url, presence: true

  # These need to be below the associations, otherwise they aren't aware of them
  include CallsToAction

  set_garden_url ENV["WIDGET_GARDEN_URL"]

  scope :in_section, lambda { |section| where(section: section) }
  scope :name_like_form, where("widgets.name LIKE '%Form'")

  def liquidized_html
    Liquid::Template.parse(self.html).render({"widget" => self}, filters: [UrlEncode])
  end

  def edit_form_html_rendered
    Liquid::Template.parse(edit_form_html).render("widget" => self)
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
      build_settings_from_microformat(component)
      true
    else
      raise "No h-g5-component found at url: #{url}"
    end
  rescue OpenURI::HTTPError => e
    logger.warn e.message
  end

  def build_settings_from_microformat(component)
    return unless component.respond_to?(:g5_property_groups)
    e_property_groups = component.g5_property_groups
    e_property_groups.each do |e_property_group|
      h_property_group = e_property_group.format
      h_property_group.g5_properties.each do |e_property|
        build_setting(h_property_group, e_property.format)
      end
    end
  end

  def build_setting(h_property_group, h_property)
    settings.build(
      name: h_property.g5_name.to_s,
      editable: h_property.g5_editable.to_s || false,
      default_value: h_property.g5_default_value.to_s,
      categories: h_property_group.try(:categories).try(:map, &:to_s)
    )
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

