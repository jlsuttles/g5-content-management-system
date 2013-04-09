module HasManyPrioritizedSettings
  extend ActiveSupport::Concern

  included do
    has_many :settings, as: :owner, dependent: :destroy
    accepts_nested_attributes_for :settings
  end

  def prioritized_settings
    PrioritizedSettings.new(self)
  end

  def settings_names
    settings.map(&:name)
  end

  def priority
    Setting::PRIORITIZED_OWNERS.index(self.class.name)
  end
end
