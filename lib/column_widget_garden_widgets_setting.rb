class ColumnWidgetGardenWidgetsSetting
  def value
    GardenWidget.where("name != ?", "Column").map(&:name)
  end
end
