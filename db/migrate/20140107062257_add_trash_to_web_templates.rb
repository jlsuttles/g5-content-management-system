class AddTrashToWebTemplates < ActiveRecord::Migration
  def change
    add_column :web_templates, :in_trash, :boolean
  end
end
