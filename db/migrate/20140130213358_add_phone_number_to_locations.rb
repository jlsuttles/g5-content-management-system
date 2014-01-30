class AddPhoneNumberToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :phone_number, :string
    ClientReader.new(ENV["G5_CLIENT_UID"]).perform
    Website.all.each do |website|
      location = website.location
      website.settings.create!(name: "location_street_address", value: location.street_address)
      website.settings.create!(name: "location_postal_code", value: location.postal_code)
      website.settings.create!(name: "location_phone_number", value: location.phone_number)
    end
  end
end
