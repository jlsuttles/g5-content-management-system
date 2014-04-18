class GardenWidgetsSetting
  attr_accessor :value

  def initialize
    update_value
    self
  end

  def update_value
    self.value = GardenWidget.map |garden_widget|
      [garden_widget.id, garden_widget.name]
    end
  end
end
