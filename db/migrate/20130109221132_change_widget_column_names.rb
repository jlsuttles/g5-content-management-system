class ChangeWidgetColumnNames < ActiveRecord::Migration
  def up
    rename_column :widgets, :css, :stylesheets
    rename_column :widgets, :javascript, :javascripts 
  end

  def down
    rename_column :widgets, :stylesheets, :css
    rename_column :widgets, :javascripts, :javascript
  end
end