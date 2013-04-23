class RenamePageLayoutToWebLayout < ActiveRecord::Migration
  def up
    rename_table :page_layouts, :web_layouts
  end

  def down
    rename_table :web_layouts, :page_layouts
  end
end
