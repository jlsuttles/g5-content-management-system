module SettingRowWidgetGardenWidgets
  extend ActiveSupport::Concern

  include SettingWidgetGardenWidgets

  GARDEN_WIDGET_NAME_SETTINGS = ["column_one_widget_name",
    "column_two_widget_name", "column_three_widget_name",
    "column_four_widget_name"]

  WIDGET_ID_SETTINGS = ["column_one_widget_id", "column_two_widget_id",
    "column_three_widget_id", "column_four_widget_id"]

  def garden_widget_name_setting?
    GARDEN_WIDGET_NAME_SETTINGS.include?(name)
  end

  def widget_id_setting_name
    WIDGET_ID_SETTINGS[GARDEN_WIDGET_NAME_SETTINGS.index(name)]
  end
end
