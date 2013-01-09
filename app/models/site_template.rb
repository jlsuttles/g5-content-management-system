class SiteTemplate < Page
  has_many :aside_widgets,  class_name: "Widget",  conditions: ['section = ?', 'aside'], foreign_key: "page_id"
  has_many :header_widgets, class_name: "Widget", conditions: ['section = ?', 'header'], foreign_key: "page_id"
  has_many :footer_widgets, class_name: "Widget", conditions: ['section = ?', 'footer'], foreign_key: "page_id"

  def sections
    %w(header aside footer)
  end

  def stylesheets
    compiled_pages_stylesheets + 
      aside_widgets.map(&:css).flatten +
      header_widgets.map(&:css).flatten +
      footer_widgets.map(&:css).flatten +
      page_layout.stylesheets +
      theme.stylesheets
  end

  def compiled_pages_stylesheets
    [File.join(Rails.root, "app", "views", "compiled_pages", "stylesheets.scss")]
  end

  def javascripts
    aside_widgets.map(&:javascript).flatten +
      header_widgets.map(&:javascript).flatten +
      footer_widgets.map(&:javascript).flatten +
      theme.javascripts
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
