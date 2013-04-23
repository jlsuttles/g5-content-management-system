module HasSettingAvailableCallsToAction
  extend ActiveSupport::Concern

  def setting_available_calls_to_action
    settings.find_or_initialize_by_name(
      name: "available_calls_to_action",
      categories: ["collection"]
    )
  end

  def set_setting_available_calls_to_action
    setting_available_calls_to_action.update_attribute(:value, Widget::AVAILABLE_CALLS_TO_ACTION)
  end
end
