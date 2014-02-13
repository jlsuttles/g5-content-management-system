class WidgetEntryDecorator < Draper::Decorator
  include HentryableDates

  delegate_all

  def name
    "Widget Deployed: #{widget_name}"
  end

  def summary
    "#{widget_name} deployed."
  end

  def author_name
    "G5 CMS"
  end

  def categories
    [widget.name.split.last.downcase, "widget", "deploy"]
  end
end
