module DefaultWebPageTemplates
  extend ActiveSupport::Concern

  DEFAULT_WEB_PAGE_TEMPLATES = [
    "Amenities",
    "Floorplans and Rates",
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
      klass = determine_class(template)
      klass.create(name: template, disabled: disabled_template?(template), website_id: id)    
    end
  end

  def disabled_template?(template)
    disabled_default_web_page_templates.include?(template)
  end

  def determine_class(template)
    begin
      template.titleize.gsub(/\s+/, '').constantize
    rescue
      WebPageTemplate
    end
  end
end
