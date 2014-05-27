class WidgetDrop < Liquid::Drop
  attr_accessor :widget 

  def initialize(widget, locations)
    @widget, @locations = widget, locations
  end

  def locations
    @locations.map(&:decorate)
  end

  def client_cities
    locations.map(&:city).uniq
  end

  def locations_in_city
    @locations.by_city(widget.city.best_value).map {|location| location.decorate.address}.to_s
  end

  def before_method(method)
    setting = widget.settings.find_by(name: method)
    setting.try(:decorate)
  end
end

