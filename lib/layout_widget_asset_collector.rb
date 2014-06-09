class LayoutWidgetAssetCollector
  def initialize(template)
    @template = template
  end

  def javascripts
    return [] unless row_widget.present?
    row_widget_javascripts
  end

  def stylesheets
    return [] unless row_widget.present?
    row_widget_stylesheets
  end

  def row_widget
    @template.widgets.map do |widget|
      widget if widget.garden_widget.name == "Row"
    end.compact.first
  end

  def row_widget_widget_ids
    row_widget.settings.map do |setting|
      setting.value if setting.name =~ /(?=.*column)(?=.*widget_id).*/
    end.compact
  end

  def row_widget_widgets
    Widget.where(id: row_widget_widget_ids)
  end

  def row_widget_javascripts
    row_widget_widgets.map(&:show_javascript).flatten.compact
  end

  def row_widget_stylesheets
    row_widget_widgets.map(&:show_stylesheets).flatten.compact
  end

  def column_widget_javascripts
  end
end
