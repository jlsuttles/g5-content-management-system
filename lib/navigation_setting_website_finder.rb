class NavigationSettingWebsiteFinder
  def initialize(setting)
    @setting = setting
  end

  def find
    return unless parent_widget
    return drop_target.web_template.website if drop_target

    parent_widget_parent_website
  end

private

  def parent_widget
    @parent_widget ||= parent_setting.owner if parent_setting
  end

  def parent_setting
    @parent_setting ||= find_setting(@setting.owner.id)
  end

  def drop_target
    @drop_target ||= parent_widget.drop_target
  end

  def parent_widget_parent_website
    find_setting(parent_widget.id).owner.drop_target.web_template.website
  end

  def find_setting(widget_id)
    Setting.find do |setting|
      setting.name =~ /(?=(column|row))(?=.*widget_id).*/ && setting.value == widget_id
    end
  end
end
