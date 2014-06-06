class RowWidgetGardenWidgetsSetting
  def value
    GardenWidget.where("name != ?", "Row").map(&:name).sort
  end
end
