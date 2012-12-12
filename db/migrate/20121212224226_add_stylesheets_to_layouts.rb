class AddStylesheetsToLayouts < ActiveRecord::Migration
  def change
    add_column :page_layouts, :stylesheets, :text
  end
end
