class CreateWidgetAttributes < ActiveRecord::Migration
  def change
    create_table :widget_attributes do |t|
      t.string :name, :value
      t.boolean :editable, default: false
      t.string :default_value
      t.integer :setting_id

      t.timestamps
    end
  end
end
