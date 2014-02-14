class WidgetEntry < ActiveRecord::Base
  include HentryableDates

  serialize :categories

  belongs_to :widget

  delegate :render_show_html,
    to: :widget, allow_nil: true, prefix: true

  before_create :set_content

  def widget_name
    widget.try(:name)
  end

  private

  def set_content
    self.content = widget_render_show_html
  end
end
