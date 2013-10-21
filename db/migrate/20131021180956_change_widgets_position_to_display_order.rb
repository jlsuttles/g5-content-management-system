class ChangeWidgetsPositionToDisplayOrder < ActiveRecord::Migration
  def up
    rename_column :widgets, :position, :display_order
  end

  def down
    rename_column :widgets, :display_order, :position
  end
end
