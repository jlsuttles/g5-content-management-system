class WidgetDrop < Liquid::Drop
  attr_accessor :widget, :locations

  def initialize(widget, locations)
    @widget, @locations = widget, locations
  end

  def client_locations
    locations.map(&:decorate)
  end

  def before_method(method)
    setting = widget.settings.find_by(name: method)
    setting.try(:decorate)
  end

  def addresses
    Location.where(id: selected_location_ids).map(&:decorate).
                                              map(&:address).to_json
  end

  def id
    widget.id
  end

private

  def selected_location_ids
    widget.included_locations.best_value.map(&:to_i)
  end
end
