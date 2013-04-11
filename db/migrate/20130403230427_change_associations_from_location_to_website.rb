class ChangeAssociationsFromLocationToWebsite < ActiveRecord::Migration
  def up
    rename_column :pages, :location_id, :website_id
  end

  def down
    rename_column :pages, :website_id, :location_id
  end
end
