class RenameWebTemplateDisabledToEnabled < ActiveRecord::Migration
  def up
    rename_column :web_templates, :disabled, :enabled
    WebTemplate.all.each do |web_template|
      web_template.update_attribute(:enabled, !web_template.enabled)
    end
  end

  def down
    rename_column :web_templates, :enabled, :disabled
    WebTemplate.all.each do |web_template|
      web_template.update_attribute(:disabled, !web_template.disabled)
    end
  end
end
