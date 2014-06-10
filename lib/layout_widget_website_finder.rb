class LayoutWidgetWebsiteFinder
  def initialize(setting)
    @setting = setting
  end

  def find
    return unless parent_widget

    if parent_widget.drop_target
      parent_widget.drop_target.web_template.website
    else
      parent_widget_parent_website
    end
  end

private

  def parent_widget
    @parent_widget ||= parent_setting.owner if parent_setting
  end

  def parent_setting
    @parent_setting ||= find_layout_setting(@setting.owner.id)
  end

  def parent_widget_parent_website
    find_layout_setting(parent_widget.id).owner.drop_target.web_template.website
  end

  def find_layout_setting(widget_id)
    Setting.all.select do |setting|
      setting.name =~ /widget_id/ && setting.value == widget_id
    end.first
  end
end
