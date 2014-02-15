class CreateGardenWidgets < ActiveRecord::Migration
  def change
    create_table :garden_widgets do |t|
      t.string :name
      t.string :slug
      t.string :url
      t.string :thumbnail
      t.text :edit_html
      t.string :edit_javascript
      t.text :show_html
      t.string :show_javascript
      t.text :lib_javascripts
      t.text :show_stylesheets
      t.text :settings

      t.timestamps
    end
  end
end
