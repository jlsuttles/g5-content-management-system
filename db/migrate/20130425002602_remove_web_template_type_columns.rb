class RemoveWebTemplateTypeColumns < ActiveRecord::Migration
  def up
    remove_column :web_layouts, :web_template_type
    remove_column :web_themes, :web_template_type
    remove_column :widgets, :web_template_type
  end

  def down
    add_column :widgets, :web_template_type, :string
    add_column :web_themes, :web_template_type, :string
    add_column :web_layouts, :web_template_type, :string
  end
end
