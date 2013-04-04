class SiteTemplate < Page
  has_many :aside_widgets,  class_name: "Widget", conditions: ['section = ?', 'aside'], foreign_key: "page_id"
  has_many :header_widgets, class_name: "Widget", conditions: ['section = ?', 'header'], foreign_key: "page_id"
  has_many :footer_widgets, class_name: "Widget", conditions: ['section = ?', 'footer'], foreign_key: "page_id"
  has_many :widgets, class_name: "Widget", foreign_key: "page_id"

  def sections
    %w(header aside footer)
  end

  def stylesheets
    layout_stylesheets + widgets.map(&:stylesheets).flatten
  end

  def layout_stylesheets
    compiled_pages_stylesheets +
      web_layout_stylesheets +
      theme_stylesheets
  end

  def compiled_pages_stylesheets
    [File.join(Rails.root, "app", "views", "compiled_pages", "stylesheets.scss")]
  end

  def web_layout_stylesheets
    web_layout.try(:stylesheets) || []
  end

  def theme_stylesheets
    theme.try(:stylesheets) || []
  end

  def javascripts
    widgets.map(&:javascripts).flatten + theme.try(:javascripts)
  end

  def primary_color
    if website.custom_colors?
      website.primary_color
    else
      theme.try(:primary_color)
    end
  end

  def secondary_color
    if website.custom_colors?
      website.secondary_color
    else
      theme.try(:secondary_color)
    end
  end
end
