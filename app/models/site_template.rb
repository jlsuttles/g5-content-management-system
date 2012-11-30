class SiteTemplate < Page
  has_many :aside_widgets,  class_name: "Widget",  conditions: ['section = ?', 'aside']
  has_many :header_widgets, class_name: "Widget", conditions: ['section = ?', 'header']
  has_many :footer_widgets, class_name: "Widget", conditions: ['section = ?', 'footer']

  before_create :set_template_flag

  def sections
    %w(header aside footer)
  end

  private

  def set_template_flag
    self.template = true
  end
end
