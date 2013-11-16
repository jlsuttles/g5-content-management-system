class MoveCustomColorsToWebThemes < ActiveRecord::Migration
  def up
    remove_column :locations, :custom_colors
    remove_column :locations, :primary_color
    remove_column :locations, :secondary_color
    remove_column :websites, :custom_colors
    remove_column :websites, :primary_color
    remove_column :websites, :secondary_color
    add_column :web_themes, :custom_colors, :boolean
    add_column :web_themes, :custom_primary_color, :string
    add_column :web_themes, :custom_secondary_color, :string
  end

  def down
    remove_column :web_themes, :custom_secondary_color
    remove_column :web_themes, :custom_primary_color
    remove_column :web_themes, :custom_colors
    add_column :websites, :secondary_color, :string
    add_column :websites, :primary_color, :string
    add_column :websites, :custom_colors, :boolean
    add_column :locations, :secondary_color, :string
    add_column :locations, :primary_color, :string
    add_column :locations, :custom_colors, :boolean
  end
end
