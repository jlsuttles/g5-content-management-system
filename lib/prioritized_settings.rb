class PrioritizedSettings
  def initialize(owner)
    @owner = owner
    @settings_names = @owner.settings_names
  end

  def to_liquid
    liquid = {}
    @settings_names.each do |setting_name|
      liquid[setting_name] = send(setting_name)
    end
    liquid
  end

  def method_missing(method_name, *args, &block)
    if @settings_names.include?(method_name)
      Setting.
        where(name: method_name).
        where("value IS NOT NULL").
        where("priority >= ?", @owner.priority).
        order("priority ASC").
        first
    else
      super
    end
  end
end
