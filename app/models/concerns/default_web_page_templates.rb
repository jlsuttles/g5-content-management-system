module DefaultWebPageTemplates
  extend ActiveSupport::Concern

  DEFAULT_WEB_PAGE_TEMPLATES = [
    "Amenities",
    "Floor Plans and Rates",
    "Maps and Directions",
    "Neighborhood",
    "Photo Gallery",
    "Residents",
    "Coupon"
  ]
  
  DISABLED_DEFAULT_WEB_PAGE_TEMPLATES = [
    "Coupon"
  ]

  included do
    after_create :configure_default_web_page_templates 
  end
  
  private

  def configure_default_web_page_templates
    DEFAULT_WEB_PAGE_TEMPLATES.each do |template|
      web_page_templates.create(name: template, disabled: disabled_template?(template))    
    end
  end

  def disabled_template?(template)
    DISABLED_DEFAULT_WEB_PAGE_TEMPLATES.include?(template)
  end
end
