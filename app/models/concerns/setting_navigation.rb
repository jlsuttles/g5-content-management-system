module SettingNavigation
  extend ActiveSupport::Concern

  included do
    before_update :update_widget_navigation_setting, if: :widget_navigation_setting_updated?
    after_update :update_widget_navigation_settings, if: :website_navigation_setting?
    scope :navigation, where(name: "navigation")
  end

  def website_navigation_setting?
    owner_type == "Website" && name == "navigation"
  end

  def widget_navigation_setting_updated?
    owner_type == "Widget" && name == "navigation" && value.is_a?(Hash)
  end

  def website_navigation_setting
    website.settings.navigation.first
  end

  def widget_navigation_settings
    website.widget_settings.navigation
  end

  def update_widget_navigation_settings
    widget_navigation_settings.map(&:update_widget_navigation_setting).map(&:save)
  end

  def update_widget_navigation_setting
    unless value
      self.value = website_navigation_setting.value
    else
      new_value = []
      website_navigation_setting.value.each_with_index do |website_partial_value, index|
        # when widget setting is updated, comes back as hash, not array
        unless (widget_partial_value = value.is_a?(Array) ? value[index] : value[index.to_s]).nil?
          website_partial_value["display"] = widget_partial_value["display"]
        end
        new_value << HashWithToLiquid[website_partial_value]
      end
      self.value = new_value
    end
    self
  end
end
