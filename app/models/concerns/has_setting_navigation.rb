require_dependency "hash_with_to_liquid"

module HasSettingNavigation
  extend ActiveSupport::Concern

  # not sure this was necessary to make it plural, there should only
  # be one website level navigation setting
  def navigation_settings
    @navigation_settings = settings.where(name: "navigation")
    unless @navigation_settings.present?
      settings.create(
        name: "navigation",
        categories: ["collection"]
      )
      @navigation_settings = settings.where(name: "navigation")
    end
    @navigation_settings
  end

  def update_navigation_settings
    navigation_settings.each do |navigation_setting|
      navigation_setting.update_attribute(:value,
      navigateable_web_templates_to_hashes)
    end
  end

  def navigateable_web_templates
    web_templates.navigateable.created_at_asc.decorate
  end

  def navigateable_web_templates_to_hashes
    navigateable_web_templates.map do |web_template|
      hash = HashWithToLiquid.new
      hash["display"] = web_template.display
      hash["title"] = web_template.name
      hash["url"] = web_template.url
      hash
    end
  end
end
