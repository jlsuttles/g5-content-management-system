class AddDisplayOrderToWebTemplates < ActiveRecord::Migration
  def change
    add_column :web_templates, :display_order, :integer
  end
end
