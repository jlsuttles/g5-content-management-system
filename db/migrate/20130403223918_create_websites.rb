class CreateWebsites < ActiveRecord::Migration
  def change
    create_table :websites do |t|
      t.references :location
      t.string :urn
      t.boolean :custom_colors, null: false, default: false
      t.string :primary_color, default: "#000000"
      t.string :secondary_color, default: "#ffffff"

      t.timestamps
    end
    add_index :websites, :location_id
  end
end
