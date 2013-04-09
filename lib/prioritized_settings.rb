class PrioritizedSettings
  def initialize(owner)
    @owner = owner
    @settings_names = @owner.settings_names
  end

  def to_liquid
    liquid = {}
    @settings_names.each do |setting_name|
      liquid[setting_name] = send(setting_name).to_liquid
    end
    liquid
  end

  def method_missing(method_name, *args, &block)
    if @settings_names.include?(method_name.to_s)
      (prioritized_setting(method_name) || my_setting(method_name)).decorate
    else
      super
    end
  end

  def prioritized_setting(setting_name)
    Setting.
      where(name: setting_name).
      where("value IS NOT NULL").
      where("priority >= ?", @owner.priority).
      order("priority ASC").
      first
  end

  def my_setting(setting_name)
    @owner.settings.find_by_name(setting_name)
  end
end
