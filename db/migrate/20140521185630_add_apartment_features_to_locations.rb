class AddApartmentFeaturesToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :primary_amenity, :string
    add_column :locations, :primary_landmark, :string
    add_column :locations, :qualifier, :string
    add_column :locations, :floor_plans, :string
  end
end
