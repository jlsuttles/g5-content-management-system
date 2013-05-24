class WebsiteTemplate < WebTemplate
  has_many :logo_widgets, class_name: "Widget", conditions: ['section = ?', 'drop-target-logo'], foreign_key: "web_template_id"
  has_many :phone_widgets, class_name: "Widget", conditions: ['section = ?', 'drop-target-phone'], foreign_key: "web_template_id"
  has_many :btn_widgets, class_name: "Widget", conditions: ['section = ?', 'drop-target-btn'], foreign_key: "web_template_id"
  has_many :nav_widgets, class_name: "Widget", conditions: ['section = ?', 'drop-target-nav'], foreign_key: "web_template_id"
  has_many :aside_widgets,  class_name: "Widget", conditions: ['section = ?', 'drop-target-aside'], foreign_key: "web_template_id"
  has_many :footer_widgets, class_name: "Widget", conditions: ['section = ?', 'drop-target-footer'], foreign_key: "web_template_id"
  has_many :widgets, class_name: "Widget", foreign_key: "web_template_id"

  after_initialize :assign_defaults

  def sections
    %w(drop-target-logo drop-target-phone drop-target-btn drop-target-nav drop-target-aside drop-target-footer)
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
    widget_lib_javascripts + web_theme_javascripts + widget_show_javascripts
  end

  def widget_show_javascripts
    widgets ? widgets.map(&:show_javascript).flatten : []
  end

  def widget_lib_javascripts
    widgets ? widgets.map(&:lib_javascripts).flatten : []
  end

  def web_theme_javascripts
    web_theme ? web_theme.javascripts : []
  end

  def primary_color
    if website.custom_colors?
      website.primary_color
    else
      web_theme.try(:primary_color)
    end
  end

  def secondary_color
    if website.custom_colors?
      website.secondary_color
    else
      web_theme.try(:secondary_color)
    end
  end

  private

  def assign_defaults
    self.name  ||= "Website Template"
    self.title ||= name
    self.slug  ||= title.parameterize
  end
end
