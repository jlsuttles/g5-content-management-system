module AfterUpdateSetSettingNavigation
  extend ActiveSupport::Concern

  included do
    after_create :update_navigation_settings
    after_update :update_navigation_settings, if: :name_changed?
  end

  private

  def update_navigation_settings
    website.try(:update_navigation_settings)
  end
end
