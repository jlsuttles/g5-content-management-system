require_dependency 'liquid_filters'

class Widget < ActiveRecord::Base
  include RankedModel
  include HasManySettings
  include ComponentGardenable

  ranks :display_order, with_same: :drop_target_id

  set_garden_url ENV["WIDGET_GARDEN_URL"]

  # TODO: add to schema
  belongs_to :garden_widget
  belongs_to :drop_target
  has_one :web_template, through: :drop_target

  has_many :widget_entries, dependent: :destroy

  after_initialize :set_defaults
  before_create :update_settings
  before_save :update_settings

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

  # TODO: def rendered_show_html
  def liquidized_html
    Liquid::Template.parse(self.html).render({"widget" => self}, filters: [UrlEncode])
  end

  # TODO: def rendered_edit_html
  def edit_form_html_rendered
    Liquid::Template.parse(edit_form_html).render("widget" => self)
  end

  private

  # TODO: Is this being used?
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

  def update_settings
    return unless garden_widget && garden_widget.settings
    garden_widget.settings.each do |garden_widget_setting|
      settings.find_or_initialize_by_name(
        name: garden_widget_setting[:name],
        editable: garden_widget_setting[:editable],
        default_value: garden_widget_setting[:default_value],
        categories: garden_widget_setting[:categories]
      )
    end
  end
end
