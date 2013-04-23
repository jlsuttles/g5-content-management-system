class RenamePropertyToSettingDropPropertyGroup < ActiveRecord::Migration
  def up
    drop_table :property_groups
    rename_table :properties, :settings
    rename_column :settings, :property_group_id, :owner_id
    add_column :settings, :owner_type, :string
    add_column :settings, :categories, :text
  end

  def down
    remove_column :settings, :categories
    remove_column :settings, :owner_type
    rename_column :settings, :owner_id, :property_group_id
    rename_table :settings, :properties
    create_table "property_groups", :force => true do |t|
      t.integer  "component_id"
      t.string   "component_type"
      t.string   "name"
      t.text     "categories"
      t.datetime "created_at",     :null => false
      t.datetime "updated_at",     :null => false
    end
  end
end
