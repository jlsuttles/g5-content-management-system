class AddWebsiteIdToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :website_id, :integer
    add_index :settings, :website_id
  end
end
