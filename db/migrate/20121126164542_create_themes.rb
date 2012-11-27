class CreateThemes < ActiveRecord::Migration
  def change
    create_table :themes do |t|
      t.string :url
      t.string :name
      t.belongs_to :page
      t.timestamps
    end
    add_index :themes, :page_id
  end
end