class AvailableGardenWidgetsSetting
  def value
    GardenWidget.where("name != ?", "Row").map(&:name)
  end
end
