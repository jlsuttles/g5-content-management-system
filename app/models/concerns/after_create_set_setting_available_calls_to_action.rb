module AfterCreateSetSettingAvailableCallsToAction
  extend ActiveSupport::Concern

  included do
    after_create :set_setting_available_calls_to_action
  end
end
