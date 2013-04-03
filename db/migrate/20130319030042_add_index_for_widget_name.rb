class AddIndexForWidgetName < ActiveRecord::Migration
  def change
    add_index :widgets, :name
  end
end
