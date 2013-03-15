class WidgetEntryDecorator < Draper::Decorator
  include HentryableDates

  delegate_all

  def name
    "Widget Deployed: #{widget.name}"
  end

  def summary
    "#{widget.name} deployed."
  end

  def author_name
    "G5 Client Hub"
  end

  def categories
    [widget.name.split.last.downcase, "widget", "deploy"]
  end
end
