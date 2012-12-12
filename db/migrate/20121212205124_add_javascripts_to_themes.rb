class AddJavascriptsToThemes < ActiveRecord::Migration
  def change
    add_column :themes, :javascripts, :text
  end
end
