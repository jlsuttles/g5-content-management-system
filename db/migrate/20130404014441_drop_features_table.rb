class DropFeaturesTable < ActiveRecord::Migration
  def up
    drop_table :features
  end

  def down
    create_table "features", :force => true do |t|
      t.string   "uid"
      t.string   "name"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end
  end
end
