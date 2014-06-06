class ColumnWidgetGardenWidgetsSetting
  def value
    GardenWidget.where("name != ?", "Column").map(&:name).sort
  end
end
