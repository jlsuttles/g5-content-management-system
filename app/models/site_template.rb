class SiteTemplate < Page
  has_many :aside_widgets,  class_name: "Widget",  conditions: ['section = ?', 'aside'], foreign_key: "page_id"
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
      page_layout_stylesheets +
      theme_stylesheets
  end

  def compiled_pages_stylesheets
    [File.join(Rails.root, "app", "views", "compiled_pages", "stylesheets.scss")]
  end
  
  def page_layout_stylesheets
    page_layout.try(:stylesheets) || []
  end

  def theme_stylesheets
    theme.try(:stylesheets) || []
  end

  def javascripts
    widgets.map(&:javascripts).flatten + theme.javascripts
  end

  def primary_color
    if location.custom_colors?
      location.primary_color
    else
      theme.try(:primary_color)
    end
  end

  def secondary_color
    if location.custom_colors?
      location.secondary_color
    else
      theme.try(:secondary_color)
    end
  end
end
