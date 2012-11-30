class SiteTemplate < Page
  has_many :aside_widgets,  class_name: "Widget",  conditions: ['section = ?', 'aside'], foreign_key: "page_id"
  has_many :header_widgets, class_name: "Widget", conditions: ['section = ?', 'header'], foreign_key: "page_id"
  has_many :footer_widgets, class_name: "Widget", conditions: ['section = ?', 'footer'], foreign_key: "page_id"

  before_create :set_template_flag

  def sections
    %w(header aside footer)
  end

  def stylesheets
    theme.stylesheets + 
      aside_widgets.map(&:css).flatten + 
      header_widgets.map(&:css).flatten + 
      footer_widgets.map(&:css).flatten
  end

  def javascripts
    aside_widgets.map(&:javascript).flatten + 
      header_widgets.map(&:javascript).flatten + 
      footer_widgets.map(&:javascript).flatten
  end

  private

  def set_template_flag
    self.template = true
  end
end
