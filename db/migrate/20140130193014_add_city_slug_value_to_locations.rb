class AddCitySlugValueToLocations < ActiveRecord::Migration
  def change
    Location.all.each do |location|
      location.city_slug = location.city.to_s.parameterize
      location.save
    end
  end
end
