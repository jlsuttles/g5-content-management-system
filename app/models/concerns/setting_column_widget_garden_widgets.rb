module SettingColumnWidgetGardenWidgets
  extend ActiveSupport::Concern

  include SettingWidgetGardenWidgets

  GARDEN_WIDGET_NAME_SETTINGS = ["row_one_widget_name", "row_two_widget_name",
                                 "row_three_widget_name", "row_four_widget_name"]

  WIDGET_ID_SETTINGS = ["row_one_widget_id", "row_two_widget_id",
                        "row_three_widget_id", "row_four_widget_id"]

  def garden_widget_name_setting?
    GARDEN_WIDGET_NAME_SETTINGS.include?(name)
  end

  def widget_id_setting_name
    WIDGET_ID_SETTINGS[GARDEN_WIDGET_NAME_SETTINGS.index(name)]
  end
end
