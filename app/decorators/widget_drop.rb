class WidgetDrop < Liquid::Drop
  attr_accessor :widget, :locations

  def initialize(widget, locations)
    @widget, @locations = widget, locations
    #widget.settings.each do |setting|
    #  self.class.send(:define_method, setting.name) do
    #    setting.decorate
    #  end
    #end
  end

  def client_locations
    locations.map do |location|
      location.decorate
    end
  end

  def before_method(method)
    setting = widget.settings.find_by(name: method)
    setting.try(:decorate)
  end
end

