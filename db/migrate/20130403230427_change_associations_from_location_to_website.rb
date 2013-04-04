class ChangeAssociationsFromLocationToWebsite < ActiveRecord::Migration
  def up
    remove_column :locations, :custom_colors
    remove_column :locations, :primary_colors
    remove_column :locations, :secondary_colors
    rename_column :pages, :location_id, :website_id
  end

  def down
    rename_column :pages, :website_id, :location_id
    add_column :locations, :secondary_colors, default: "#fffffff"
    add_column :locations, :primary_colors, default: "#000000"
    add_column :locations, :custom_colors, null: false, default: false
  end
end
