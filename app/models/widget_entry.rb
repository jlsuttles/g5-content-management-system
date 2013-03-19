class WidgetEntry < ActiveRecord::Base
  include HentryableDates

  attr_accessible :widget_id, :content

  serialize :categories

  belongs_to :widget

  before_create :save_widget_html

  private

  def save_widget_html
    self.content = widget.html if widget
  end
end
