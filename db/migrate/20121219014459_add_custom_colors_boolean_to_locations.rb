class AddCustomColorsBooleanToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :custom_colors, :boolean, default: false, null: false
  end
end
