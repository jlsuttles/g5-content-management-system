class AddStylesheetsToThemes < ActiveRecord::Migration
  def change
    add_column :themes, :stylesheets, :text
  end
end
