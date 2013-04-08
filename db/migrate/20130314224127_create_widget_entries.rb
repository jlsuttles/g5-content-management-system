class CreateWidgetEntries < ActiveRecord::Migration
  def change
    create_table :widget_entries do |t|
      t.references :widget
      t.text :content

      t.timestamps
    end
  end
end
