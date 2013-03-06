class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.integer :component_id
      t.string :component_type
      t.string :name
      t.text :categories

      t.timestamps
    end
  end
end
