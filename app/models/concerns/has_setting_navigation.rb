require_dependency "hash_with_to_liquid"

module HasSettingNavigation
  extend ActiveSupport::Concern

  def set_setting_navigation
    setting_navigation.update_attribute(:value, generate_setting_navigation)
  end

  def setting_navigation
    settings.find_or_initialize_by_name("navigation")
  end

  def generate_setting_navigation
    web_page_templates.decorate.map do |web_page_template|
      hash = HashWithToLiquid.new
      hash["display"] = web_page_template.display
      hash["title"] = web_page_template.title
      hash["url"] = web_page_template.url
      hash
    end
  end
end
