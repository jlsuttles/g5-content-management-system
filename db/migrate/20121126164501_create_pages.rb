class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :location_id
      t.string :name
      t.timestamps
    end
    add_index :pages, :location_id
  end
end