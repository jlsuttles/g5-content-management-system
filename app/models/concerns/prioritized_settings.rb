module PrioritizedSettings
  extend ActiveSupport::Concern

  included do
    has_many :settings, as: :owner, dependent: :destroy
    accepts_nested_attributes_for :settings
  end

  def prioritized_settings
    PrioritizedSettingsSearch.new(self)
  end

  def settings_names
    settings.pluck(:name)
  end
end
