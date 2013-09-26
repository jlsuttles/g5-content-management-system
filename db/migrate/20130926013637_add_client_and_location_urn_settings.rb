class AddClientAndLocationUrnSettings < ActiveRecord::Migration
  def up
    client = Client.first
    Location.all.each do |location|
      website = location.website
      website.settings.create!(name: "client_urn", value: client.urn)
      website.settings.create!(name: "location_urn", value: location.urn)
    end
  end

  def down
  end
end
