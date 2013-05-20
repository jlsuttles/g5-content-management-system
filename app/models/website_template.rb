class WebsiteTemplate < WebTemplate
  has_many :aside_widgets,  class_name: "Widget", conditions: ['section = ?', 'aside'], foreign_key: "web_template_id"
  has_many :header_widgets, class_name: "Widget", conditions: ['section = ?', 'header'], foreign_key: "web_template_id"
  has_many :footer_widgets, class_name: "Widget", conditions: ['section = ?', 'footer'], foreign_key: "web_template_id"
  has_many :widgets, class_name: "Widget", foreign_key: "web_template_id"

  after_initialize :assign_defaults
  after_create :create_default_header_widgets
  after_create :create_default_footer_widgets

  def sections
    %w(header aside footer)
  end

  def default_header_widgets
    %w(logo simple-nav)
  end

  def default_footer_widgets
    %w(simple-nav hcard hours)
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
    web_theme_javascripts + widget_show_javascripts
  end

  def widget_show_javascripts
    widgets ? widgets.map(&:show_javascript).flatten : []
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

  def create_default_header_widgets
    default_header_widgets.reverse.each do |widget|
      url = Widget.build_widget_url(widget)
      widgets.create(url: url, section: "header")
    end
  end

  def create_default_footer_widgets
    default_footer_widgets.reverse.each do |widget|
      url = Widget.build_widget_url(widget)
      widgets.create(url: url, section: "footer")
    end
  end

  def assign_defaults
    self.name  ||= "Website Template"
    self.title ||= name
    self.slug  ||= title.parameterize
  end
end
