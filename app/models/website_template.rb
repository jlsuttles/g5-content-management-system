class WebsiteTemplate < WebTemplate
  has_many :aside_widgets,  class_name: "Widget", conditions: ['section = ?', 'aside'], foreign_key: "web_template_id"
  has_many :header_widgets, class_name: "Widget", conditions: ['section = ?', 'header'], foreign_key: "web_template_id"
  has_many :footer_widgets, class_name: "Widget", conditions: ['section = ?', 'footer'], foreign_key: "web_template_id"
  has_many :widgets, class_name: "Widget", foreign_key: "web_template_id"

  after_initialize :assign_defaults

  def sections
    %w(header aside footer)
  end

  def stylesheets
    layout_stylesheets + widget_stylesheets
  end

  def layout_stylesheets
    compiled_pages_stylesheets +
      web_layout_stylesheets +
      web_theme_stylesheets
  end

  def compiled_pages_stylesheets
    [File.join(Rails.root, "app", "views", "compiled_pages", "stylesheets.scss")]
  end

  def web_layout_stylesheets
    web_layout ? web_layout.stylesheets : []
  end

  def web_theme_stylesheets
    web_theme ? web_theme.stylesheets : []
  end

  def widget_stylesheets
    widgets ? widgets.map(&:stylesheets).flatten : []
  end

  def javascripts
    web_theme_javascripts + widget_javascripts
  end

  def widget_javascripts
    widgets ? widgets.map(&:javascripts).flatten : []
  end

  def web_theme_javascripts
    web_theme ? web_theme.javascripts : []
  end

  private

  def assign_defaults
    self.name ||= "Website Template"
    self.title ||= name
  end
end
