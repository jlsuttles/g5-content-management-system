class RenameThemeToWebTheme < ActiveRecord::Migration
  def up
    rename_table :themes, :web_themes
  end

  def down
    rename_table :web_themes, :themes
  end
end
