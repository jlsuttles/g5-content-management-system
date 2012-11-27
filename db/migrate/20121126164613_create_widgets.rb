class CreateWidgets < ActiveRecord::Migration
  def change
    create_table :widgets do |t|
      t.string :url
      t.string :name
      t.integer :page_id, :position
      t.text :html, :css, :javascript

      t.timestamps
    end
    add_index :widgets, :page_id
  end
end