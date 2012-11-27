class CreatePageLayouts < ActiveRecord::Migration
  def change
    create_table :page_layouts do |t|
      t.string :url
      t.string :name
      t.integer :page_id
      t.text :html

      t.timestamps
    end
    add_index :page_layouts, :page_id
  end
end