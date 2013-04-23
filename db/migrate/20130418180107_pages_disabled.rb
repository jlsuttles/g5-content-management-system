class PagesDisabled < ActiveRecord::Migration
  def change
    add_column :web_templates, :disabled, :boolean
  end
end
