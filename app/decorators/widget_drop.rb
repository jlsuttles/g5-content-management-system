class WidgetDrop < Liquid::Drop
  attr_accessor :widget

  def initialize(widget)
    @widget = widget
    widget.settings.each do |setting|
      self.class.send(:define_method, setting.name) do
        setting.decorate
      end
    end
  end

  def locations
    widget.drop_target.web_template.client.locations
  end
end

