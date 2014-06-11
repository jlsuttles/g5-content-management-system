class NavigationSettingWebsiteFinder
  def initialize(setting)
    @setting = setting
    @widget = @setting.owner
    @website = nil
  end

  def find
    loop do
      setting = find_setting(@widget.id)

      return unless setting

      website_for(setting.owner)

      return @website unless @website.nil?
    end
  end

private

  def website_for(widget)
    @widget = widget
    @website = @widget.drop_target.web_template.website if @widget.drop_target
  end

  def find_setting(widget_id)
    Setting.find do |setting|
      setting.name =~ /(?=(column|row))(?=.*widget_id).*/ && setting.value == widget_id
    end
  end
end
