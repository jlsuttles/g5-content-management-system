module SettingWidgetGardenWidgets
  extend ActiveSupport::Concern

  included do
    after_update :update_widget_id_setting, if: :garden_widget_name_setting?
  end

  def update_widget_id_setting
    if value_changed?
      create_new_widget
      destroy_old_widget
      assign_new_widget
    end
  end

  def create_new_widget
    @new_widget = Widget.create(garden_widget_id: garden_widget_id)
  end

  def destroy_old_widget
    Widget.find(widget_id_setting_value).try(:destroy) if widget_id_setting_value
  end

  def assign_new_widget
    widget_id_setting.update_attributes(value: @new_widget.id) if widget_id_setting
  end

  def garden_widget_id
    GardenWidget.where(name: best_value).first.try(:id)
  end

  def widget_id_setting
    owner.settings.where(name: widget_id_setting_name).first
  end

  def widget_id_setting_value
    widget_id_setting.try(:value)
  end
end
