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
  ].freeze
  
  DISABLED_DEFAULT_WEB_PAGE_TEMPLATES = [
    "Coupon"
  ].freeze

  included do
    after_create :configure_default_web_page_templates 
  end
  
  def disabled_default_web_page_templates
    @disabled_default_web_page_templates ||= DISABLED_DEFAULT_WEB_PAGE_TEMPLATES
  end

  def default_web_page_templates
    @default_web_page_templates ||= DEFAULT_WEB_PAGE_TEMPLATES 
  end

  private

  def configure_default_web_page_templates
    default_web_page_templates.each do |template|
      web_page_templates.create(name: template, disabled: disabled_template?(template))    
    end
  end

  def disabled_template?(template)
    disabled_default_web_page_templates.include?(template)
  end
end
