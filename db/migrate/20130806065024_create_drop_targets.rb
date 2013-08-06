class CreateDropTargets < ActiveRecord::Migration
  def change
    create_table :drop_targets do |t|
      t.integer :web_template_id
      t.string :html_id

      t.timestamps
    end
  end
end
