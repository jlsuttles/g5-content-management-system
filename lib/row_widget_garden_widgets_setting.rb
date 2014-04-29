class RowWidgetGardenWidgetsSetting
  def value
    GardenWidget.where("name != ?", "Row").map(&:name)
  end
end
