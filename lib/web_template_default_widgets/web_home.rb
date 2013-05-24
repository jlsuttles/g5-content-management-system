module WebTemplateDefaultWidgets
  class WebHome
    DEFAULTS = {
      "main" => ["photo"],
    }

    def initialize(web_home_template)
      @web_home_template = web_home_template
    end

    def create
      if @web_home_template.save
        create_default_widgets
      end
    end

    def create_default_widgets
      DEFAULTS.each_pair do |drop_target, widget_names|
        widget_names.each do |widget_name|
          create_default_widget(widget_name, drop_target)
        end
      end
    end

    def create_default_widget(widget_name, drop_target)
      @web_home_template.widgets.create(
        url: Widget.build_widget_url(widget_name),
        section: drop_target,
        removeable: false
      )
    end
  end
end
