class LayoutWidgetAssetCollector
  def initialize(template)
    @template = template
  end

  def javascripts
    return [] unless row_widget.present?
    (row_widget_javascripts + column_widget_javascripts).flatten.compact
  end

  def stylesheets
    return [] unless row_widget.present?
    row_widget_stylesheets + column_widget_stylesheets
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


    #row_widget.settings.where("name REGEXP ?" => "/(?=.*column)(?=.*widget_id).*/").map(&:value)
  end

  def row_widget_widgets
    @row_widget_widgets ||= Widget.where(id: row_widget_widget_ids)
  end

  def row_widget_javascripts
    row_widget_widgets.map(&:lib_javascripts) +
    row_widget_widgets.map(&:show_javascript)
  end

  def row_widget_stylesheets
    row_widget_widgets.map(&:show_stylesheets).flatten.compact
  end


  def javascripts_for(widgets)
    widgets.map(&:lib_javascripts) + widgets.map(&:show_javascript)
  end



  def column_widget
    row_widget_widgets.map do |widget|
      widget if widget.garden_widget.name == "Column"
    end.compact.first
  end

  def column_widget_widget_ids
    column_widget.settings.map do |setting|
      setting.value if setting.name =~ /(?=.*row)(?=.*widget_id).*/
    end.compact
  end

  def column_widget_widgets
    @column_widget_widgets ||= Widget.where(id: column_widget_widget_ids)
  end

  def column_widget_javascripts
    return [] unless column_widget.present?
    column_widget_widgets.map(&:lib_javascripts) +
    column_widget_widgets.map(&:show_javascript)
  end

  def column_widget_stylesheets
    return [] unless column_widget.present?
    column_widget_widgets.map(&:show_stylesheets).flatten.compact
  end
end
