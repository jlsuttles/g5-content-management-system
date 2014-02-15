class AddGardenModelForeignIds < ActiveRecord::Migration
  def up
    add_column :web_layouts, :garden_web_layout_id, :integer
    add_column :web_themes, :garden_web_theme_id, :integer
    add_column :widgets, :garden_widget_id, :integer
    add_index :web_layouts, :garden_web_layout_id
    add_index :web_themes, :garden_web_theme_id
    add_index :widgets, :garden_widget_id
  end

  def down
    remove_column :web_layouts, :garden_web_layout_id
    remove_column :web_themes, :garden_web_theme_id
    remove_column :widgets, :garden_widget_id
  end
end
