class WidgetEntry < ActiveRecord::Base
  include HentryableDates

  attr_accessible :widget_id, :content

  serialize :categories

  belongs_to :widget

  before_create :save_widget_html

  def widget_name
    widget.name if widget
  end

  def widget_html
    widget.html if widget
  end

  private

  def save_widget_html
    self.content = widget_html
  end
end
