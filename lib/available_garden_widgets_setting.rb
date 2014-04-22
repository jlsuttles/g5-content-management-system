class AvailableGardenWidgetsSetting
  def value
    GardenWidget.all.map(&:name)
  end
end
