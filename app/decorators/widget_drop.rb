class WidgetDrop < Liquid::Drop
  attr_accessor :widget, :locations

  def initialize(widget, locations)
    @widget, @locations = widget, locations
  end

  def client_locations
    locations.map(&:decorate)
  end

  def client_cities
    locations.map(&:city).uniq
  end

  def before_method(method)
    setting = widget.settings.find_by(name: method)
    setting.try(:decorate)
  end
end

