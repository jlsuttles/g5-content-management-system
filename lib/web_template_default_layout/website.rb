module WebTemplateDefaultLayout
  class Website
    DEFAULT = "main-first-sidebar-left"

    def initialize(website_template)
      @website_template = website_template
    end

    def create
      if @website_template.save
        create_default_layout(DEFAULT)
      end
    end

    def create_default_layout(layout_name)
      @website_template.create_web_layout(
        url: WebLayout.build_layout_url(layout_name)
      )
    end
  end
end
