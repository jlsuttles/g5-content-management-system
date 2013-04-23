class RemoveDefaultFromWebTemplateType < ActiveRecord::Migration
  def up
    remove_column :web_templates, :type
    add_column :web_templates, :type, :string
  end

  def down
    change_column :web_templates, :type, :string, default: "Page"
  end
end
