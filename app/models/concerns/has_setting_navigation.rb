require_dependency "hash_with_to_liquid"

module HasSettingNavigation
  extend ActiveSupport::Concern

  def setting_navigation
    settings.find_or_initialize_by_name("navigation")
  end

  def set_setting_navigation
    setting_navigation.update_attribute(:value, web_page_templates_to_hashes)
  end

  def web_page_templates_to_hashes
    web_page_templates.decorate.map do |web_page_template|
      hash = HashWithToLiquid.new
      hash["display"] = web_page_template.display
      hash["title"] = web_page_template.title
      hash["url"] = web_page_template.url
      hash
    end
  end
end
