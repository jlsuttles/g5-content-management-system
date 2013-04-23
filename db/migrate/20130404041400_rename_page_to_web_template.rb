class RenamePageToWebTemplate < ActiveRecord::Migration
  def up
    rename_table :pages, :web_templates
    rename_column :web_layouts, :page_id, :web_template_id
    add_column :web_layouts, :web_template_type, :string
    rename_column :themes, :page_id, :web_template_id
    add_column :themes, :web_template_type, :string
    rename_column :widgets, :page_id, :web_template_id
    add_column :widgets, :web_template_type, :string
  end

  def down
    remove_column :widgets, :web_template_type
    rename_column :widgets, :web_template_id, :page_id
    remove_column :themes, :web_template_type
    rename_column :themes, :web_template_id, :page_id
    remove_column :web_layouts, :web_template_type
    rename_column :web_layouts, :web_template_id, :page_id
    rename_table :web_templates, :pages
  end
end
