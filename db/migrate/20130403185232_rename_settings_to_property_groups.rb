class RenameSettingsToPropertyGroups < ActiveRecord::Migration
  def up
    rename_table :settings, :property_groups
    rename_column :widget_attributes, :setting_id, :property_group_id
  end

  def down
    rename_column :widget_attributes, :property_group_id, :setting_id
    rename_table :property_groups, :settings
  end
end
