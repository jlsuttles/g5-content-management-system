class Widget < ActiveRecord::Base
  include RankedModel
  include HasManySettings

  ranks :display_order, with_same: :drop_target_id

  # TODO: add to schema
  belongs_to :garden_widget
  belongs_to :drop_target
  has_one :web_template, through: :drop_target
  has_many :widget_entries, dependent: :destroy

  delegate :website_id,
    to: :web_template, allow_nil: true

  delegate :html_id,
    to: :drop_target, allow_nil: true

  delegate :name, :url, :thumbnail, :edit_html, :edit_javascript, :show_html,
    :show_javascript, :lib_javascripts, :show_stylesheets,
    to: :garden_widget, allow_nil: true

  # prefix means access with `garden_widget_settings` not `settings`
  delegate :settings,
    to: :garden_widget, allow_nil: true, prefix: true

  after_initialize :set_defaults
  before_create :update_settings
  before_save :update_settings

  scope :name_like_form, where("widgets.name LIKE '%Form'")
  scope :meta_description, where(name: "Meta Description")
  scope :not_meta_description, where("widgets.name != ?", "Meta Description")

  def kind_of_widget?(kind)
    name == kind
  end

  def render_show_html
    Liquid::Template.parse(show_html).render("widget" => self)
  end

  def render_edit_html
    Liquid::Template.parse(edit_html).render("widget" => self)
  end

  def create_widget_entry_if_updated
    widget_entries.create if updated_since_last_widget_entry
  end

  def updated_since_last_widget_entry
    return true if widget_entries.blank?
    updated_at > widget_entries.maximum(:updated_at)
  end

  private

  # TODO: Is this being used?
  def set_defaults
    self.removeable = true
  end

  def update_settings
    return unless garden_widget_settings
    garden_widget_settings.each do |garden_widget_setting|
      settings.find_or_initialize_by_name(
        name: garden_widget_setting[:name],
        editable: garden_widget_setting[:editable],
        default_value: garden_widget_setting[:default_value],
        categories: garden_widget_setting[:categories]
      )
    end
  end
end
