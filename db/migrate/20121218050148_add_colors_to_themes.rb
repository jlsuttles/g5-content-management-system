class AddColorsToThemes < ActiveRecord::Migration
  def change
    add_column :themes, :colors, :text
  end
end
