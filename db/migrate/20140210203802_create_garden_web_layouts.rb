class CreateGardenWebLayouts < ActiveRecord::Migration
  def change
    create_table :garden_web_layouts do |t|
      t.string :name
      t.string :slug
      t.string :url
      t.string :thumbnail
      t.text :stylesheets
      t.text :html

      t.timestamps
    end
  end
end
