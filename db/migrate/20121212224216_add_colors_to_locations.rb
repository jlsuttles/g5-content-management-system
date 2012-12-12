class AddColorsToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :primary_color, :string, default: "#000000"
    add_column :locations, :secondary_color, :string, default: "#ffffff"
  end
end
