module SettingAvailableGardenWidgets
  extend ActiveSupport::Concern

  SELECTED_GARDEN_WIDGET_SETTING_NAMES = ["selected_garden_widget_one",
    "selected_garden_widget_two", "selected_garden_widget_three",
    "selected_garden_widget_four"]

  WIDGET_ID_SETTING_NAMES = ["widget_one_id", "widget_two_id",
    "widget_three_id", "widget_four_id"]

  included do
    after_update :update_widget_id_setting, if: :selected_garden_widget_setting?
  end

  def update_widget_id_setting
    if value_changed?
      create_new_widget
      destroy_old_widget
      assign_new_widget
    end
  end

  def selected_garden_widget_setting?
    SELECTED_GARDEN_WIDGET_SETTING_NAMES.include?(name)
  end

  def create_new_widget
    @new_widget = Widget.create(garden_widget_id: selected_garden_widget_id)
  end

  def destroy_old_widget
    Widget.find(widget_id_setting_value).destroy
  end

  def assign_new_widget
    widget_id_setting.update_attributes(value: @new_widget.id)
  end

  def selected_garden_widget_id
    GardenWidget.where(name: best_value).first.try(:id)
  end

  def widget_id_setting_name
    WIDGET_ID_SETTING_NAMES[SELECTED_GARDEN_WIDGET_SETTING_NAMES.index(name)]
  end

  def widget_id_setting
    owner.settings.where(name: widget_id_setting_name).first
  end

  def widget_id_setting_value
    widget_id_setting.try(:value)
  end
end
