class AddPolymorphismToWebsite < ActiveRecord::Migration
  def change
    rename_column :websites, :location_id, :owner_id
    add_column :websites, :owner_type, :string
  end
end
