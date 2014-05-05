module SettingRowWidgetGardenWidgets
  extend ActiveSupport::Concern

  GARDEN_WIDGET_NAME_SETTINGS = ["column_one_widget_name",
    "column_two_widget_name", "column_three_widget_name",
    "column_four_widget_name"]

  WIDGET_ID_SETTINGS = ["column_one_widget_id", "column_two_widget_id",
    "column_three_widget_id", "column_four_widget_id"]

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

  def garden_widget_name_setting?
    GARDEN_WIDGET_NAME_SETTINGS.include?(name)
  end

  def create_new_widget
    @new_widget = Widget.create(garden_widget_id: garden_widget_id)
  end

  def destroy_old_widget
    Widget.find(widget_id_setting_value).try(:destroy) if widget_id_setting_value
  end

  def assign_new_widget
    widget_id_setting.update_attributes(value: @new_widget.id)
  end

  def garden_widget_id
    GardenWidget.where(name: best_value).first.try(:id)
  end

  def widget_id_setting_name
    WIDGET_ID_SETTINGS[GARDEN_WIDGET_NAME_SETTINGS.index(name)]
  end

  def widget_id_setting
    owner.settings.where(name: widget_id_setting_name).first
  end

  def widget_id_setting_value
    widget_id_setting.try(:value)
  end
end
