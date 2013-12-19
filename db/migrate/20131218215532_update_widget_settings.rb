class UpdateWidgetSettings < ActiveRecord::Migration
  def up
    Website.all.each do |website|
      website.settings.find_or_create_by_name!(name: "location_street_address", value: website.location.street_address)
      website.settings.find_or_create_by_name!(name: "location_city", value: website.location.city)
      website.settings.find_or_create_by_name!(name: "location_state", value: website.location.state)
      website.settings.find_or_create_by_name!(name: "location_postal_code", value: website.location.postal_code)
    end
  end

  def down
  end
end
