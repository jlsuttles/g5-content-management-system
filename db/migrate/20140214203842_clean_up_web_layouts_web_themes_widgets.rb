class CleanUpWebLayoutsWebThemesWidgets < ActiveRecord::Migration
  def up
    remove_column :web_layouts, :url
    remove_column :web_layouts, :name
    remove_column :web_layouts, :html
    remove_column :web_layouts, :stylesheets
    remove_column :web_layouts, :thumbnail

    remove_column :web_themes, :url
    remove_column :web_themes, :name
    remove_column :web_themes, :stylesheets
    remove_column :web_themes, :thumbnail
    remove_column :web_themes, :javascripts
    remove_column :web_themes, :colors

    remove_column :widgets, :url
    remove_column :widgets, :name
    remove_column :widgets, :html
    remove_column :widgets, :stylesheets
    remove_column :widgets, :thumbnail
    remove_column :widgets, :edit_form_html
    remove_column :widgets, :edit_javascript
    remove_column :widgets, :show_javascript
    remove_column :widgets, :lib_javascripts
  end

  def down
    add_column :widgets, :lib_javascripts, :text
    add_column :widgets, :show_javascript, :string
    add_column :widgets, :edit_javascript, :string
    add_column :widgets, :edit_form_html, :text
    add_column :widgets, :thumbnail, :string
    add_column :widgets, :stylesheets, :text
    add_column :widgets, :html, :text
    add_column :widgets, :name, :string
    add_column :widgets, :url, :string

    add_column :web_themes, :colors, :text
    add_column :web_themes, :javascripts, :text
    add_column :web_themes, :thumbnail, :string
    add_column :web_themes, :stylesheets, :text
    add_column :web_themes, :html, :text
    add_column :web_themes, :name, :string
    add_column :web_themes, :url, :string

    add_column :web_layouts, :thumbnail, :string
    add_column :web_layouts, :stylesheets, :text
    add_column :web_layouts, :html, :text
    add_column :web_layouts, :name, :string
    add_column :web_layouts, :url, :string
  end
end
