class SiteTemplate < Page
  # attr_accessible :title, :body
  # has_many :widgets, foreign_key: :page_id
  has_many :aside_widgets,  class_name: "Widget",  conditions: ['section = ?', 'aside']
  has_many :header_widgets, class_name: "Widget", conditions: ['section = ?', 'header']
  has_many :footer_widgets, class_name: "Widget", conditions: ['section = ?', 'footer']
  before_create :set_template_flag
  
  def sections
    %w(header aside footer)
  end
  
  def set_template_flag
    self.template = true
  end

end
