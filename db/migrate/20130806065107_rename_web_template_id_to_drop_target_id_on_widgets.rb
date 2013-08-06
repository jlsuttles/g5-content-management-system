class RenameWebTemplateIdToDropTargetIdOnWidgets < ActiveRecord::Migration
  def up
    rename_column :widgets, :web_template_id, :drop_target_id
  end

  def down
    rename_column :widgets, :drop_target_id, :web_template_id
  end
end
