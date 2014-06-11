class NavigationSettingWebsiteFinder
  def initialize(setting)
    @setting = setting
  end

  def find
    return unless parent_widget
    return drop_target.web_template.website if drop_target
    return parent_widget_drop_target.web_template.website if parent_widget_drop_target

    parent_widget_parent_widget_website
  end

private

  def parent_setting
    @parent_setting ||= find_setting(@setting.owner.id)
  end

  def parent_widget
    @parent_widget ||= parent_setting.owner if parent_setting
  end

  def drop_target
    @drop_target ||= parent_widget.drop_target
  end

  def parent_widget_setting
    @parent_widget_setting ||= find_setting(parent_widget.id)
  end

  def parent_widget_parent_widget
    @parent_widget_parent_widget ||= parent_widget_setting.owner
  end

  def parent_widget_drop_target
    @parent_widget_drop_target ||= parent_widget_parent_widget.drop_target
  end

  def parent_widget_parent_setting
    @parent_widget_parent_setting ||= find_setting(parent_widget_parent_widget.id)
  end

  def parent_widget_parent_widget_website
    if parent_widget_parent_setting
      parent_widget_parent_setting.owner.drop_target.web_template.website
    end
  end

  def find_setting(widget_id)
    Setting.find do |setting|
      setting.name =~ /(?=(column|row))(?=.*widget_id).*/ && setting.value == widget_id
    end
  end
end
