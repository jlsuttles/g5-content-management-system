class RenameWidgetAttributesToProperties < ActiveRecord::Migration
  def up
    rename_table :widget_attributes, :properties
  end

  def down
    rename_table :properties, :widget_attributes
  end
end
