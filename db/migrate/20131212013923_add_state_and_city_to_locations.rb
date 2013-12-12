class AddStateAndCityToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :state, :string
    add_column :locations, :city, :string
  end
end
