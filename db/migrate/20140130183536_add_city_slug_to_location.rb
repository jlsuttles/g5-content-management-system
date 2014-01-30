class AddCitySlugToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :city_slug, :string
    Location.all.each do |location|
      location.city_slug = location.city.to_s.parameterize
    end
  end
end
