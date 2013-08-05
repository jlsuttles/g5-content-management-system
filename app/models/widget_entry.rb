class WidgetEntry < ActiveRecord::Base
  include HentryableDates

  serialize :categories

  belongs_to :widget

  before_create :save_widget_liquidized_html

  def widget_name
    widget.name if widget
  end

  def widget_liquidized_html
    widget.liquidized_html if widget
  end

  private

  def save_widget_liquidized_html
    self.content = widget_liquidized_html
  end
end
