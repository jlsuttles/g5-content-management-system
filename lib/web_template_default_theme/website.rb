module WebTemplateDefaultTheme
  class Website
    DEFAULT = "classic"

    def initialize(website_template)
      @website_template = website_template
    end

    def create
      if @website_template.save
        create_default_theme(DEFAULT)
      end
    end

    def create_default_theme(theme_name)
      @website_template.create_web_theme(
        url: WebTheme.build_theme_url(theme_name)
      )
    end
  end
end
