module AfterUpdateSetSettingNavigation
  extend ActiveSupport::Concern

  included do
    after_create :set_setting_navigation
    after_update :set_setting_navigation, if: :title_changed?
  end

  private

  def set_setting_navigation
    website.try(:set_setting_navigation)
  end
end
