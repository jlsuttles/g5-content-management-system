class FixLocationsUrns < ActiveRecord::Migration
  def up
    Location.all.each do |location|
      location.update_attribute(:urn, location.uid.split("/").last)
    end
  end

  def down
  end
end
