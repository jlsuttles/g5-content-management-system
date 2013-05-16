class AddEditShowJavascriptToWidget < ActiveRecord::Migration
  def up
    remove_column :widgets, :javascripts
    add_column :widgets, :edit_javascript, :string
    add_column :widgets, :show_javascript, :string
  end

  def down
    add_column :widgets, :javascripts, :string
    remove_column :widgets, :edit_javascript
    remove_column :widgets, :show_javascript
  end
end
