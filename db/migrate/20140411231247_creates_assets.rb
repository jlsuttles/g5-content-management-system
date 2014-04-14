class CreatesAssets < ActiveRecord::Migration
  def up
    create_table :assets do |t|
      t.string :name
      t.string :url
      t.belongs_to :website
      t.timestamps
    end
  end

  def down
    drop_table :assets
  end
end
