class AddUrnToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :urn, :string
    add_index :locations, :urn
  end
end