class AddLibJavascriptsToWidgets < ActiveRecord::Migration
  def change
    add_column :widgets, :lib_javascripts, :text
  end
end
