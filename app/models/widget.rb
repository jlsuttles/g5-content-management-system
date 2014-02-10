require_dependency 'liquid_filters'

class Widget < ActiveRecord::Base
  include RankedModel
  include HasManySettings
  include ComponentGardenable

  ranks :display_order, with_same: :drop_target_id

  set_garden_url ENV["WIDGET_GARDEN_URL"]

  # serialize :stylesheets, Array
  # serialize :lib_javascripts, Array

  belongs_to :garden_widget
  belongs_to :drop_target
  has_one :web_template, through: :drop_target

  has_many :widget_entries, dependent: :destroy

  after_initialize :set_defaults
  # before_create :assign_attributes_from_url
  before_create :build_settings

  # validates :url, presence: true

  scope :name_like_form, where("widgets.name LIKE '%Form'")
  scope :meta_description, where(name: "Meta Description")
  scope :not_meta_description, where("widgets.name != ?", "Meta Description")

  def website_id
    web_template.website_id if web_template
  end

  def html_id
    drop_target.html_id if drop_target
  end

  def kind_of_widget?(kind)
    name == kind
  end

  # def rendered_show_html
  def liquidized_html
    Liquid::Template.parse(self.html).render({"widget" => self}, filters: [UrlEncode])
  end

  # def rendered_edit_html
  def edit_form_html_rendered
    Liquid::Template.parse(edit_form_html).render("widget" => self)
  end

  # def assign_attributes_from_url
  #   component = Microformats2.parse(url).first
  #   if component
  #     self.name        = component.name.to_s
  #     self.thumbnail      = component.photo.to_s
  #     self.html           = get_show_html(component)
  #     self.edit_form_html = get_edit_form_html(component)
  #     self.stylesheets = component.g5_stylesheets.try(:map) {|s|s.to_s} if component.respond_to?(:g5_stylesheets)
  #     self.show_javascript =  component.g5_show_javascript.to_s if component.respond_to?(:g5_show_javascript)
  #     self.lib_javascripts = component.g5_lib_javascripts.try(:map) {|j|j.to_s} if component.respond_to?(:g5_lib_javascripts)
  #     self.edit_javascript =  component.g5_edit_javascript.to_s if component.respond_to?(:g5_edit_javascript)

  #     build_settings_from_microformat(component)
  #     true
  #   else
  #     raise "No h-g5-component found at url: #{url}"
  #   end
  # rescue OpenURI::HTTPError => e
  #   Rails.logger.warn e.message
  # end

  private

  # Is this being used?
  def set_defaults
    self.removeable = true
  end

  def create_widget_entry_if_updated
    widget_entries.create if updated_since_last_widget_entry
  end

  def updated_since_last_widget_entry
    return true if widget_entries.blank?
    updated_at > widget_entries.maximum(:updated_at)
  end

  # def build_settings_from_microformat(component)
  #   return unless component.respond_to?(:g5_property_groups)
  #   e_property_groups = component.g5_property_groups
  #   e_property_groups.each do |e_property_group|
  #     h_property_group = e_property_group.format
  #     h_property_group.g5_properties.each do |e_property|
  #       build_setting(h_property_group, e_property.format)
  #     end
  #   end
  # end

  def update_settings
    return unless garden_widget && garden_widget.settings
    garden_widget.settings.each do |setting|
      settings.find_or_initialize_by_name(
        name: h_property.g5_name.to_s,
        editable: h_property.g5_editable.to_s || false,
        default_value: h_property.g5_default_value.to_s,
        categories: h_property_group.try(:categories).try(:map, &:to_s)
      )
    end
  end
end
