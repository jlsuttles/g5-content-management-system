module HasManySettings
  extend ActiveSupport::Concern

  included do
    has_many :settings, as: :owner, dependent: :destroy
    accepts_nested_attributes_for :settings
  end

  def priority
    Setting::PRIORITIZED_OWNERS.index(self.class.name)
  end

  def to_liquid
    liquid = {}
    settings_names.each do |setting_name|
      liquid[setting_name] = send(setting_name).to_liquid
    end
    liquid
  end

  def settings_names
    settings.map(&:name)
  end

  def method_missing(method_name, *args, &block)
    if settings_names.include?(method_name.to_s)
      settings.find_or_initialize_by_name(method_name).decorate
    else
      super
    end
  end
end
