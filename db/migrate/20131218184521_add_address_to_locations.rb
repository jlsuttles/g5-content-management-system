class AddAddressToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :street_address, :string
    add_column :locations, :postal_code, :string
  end
end
