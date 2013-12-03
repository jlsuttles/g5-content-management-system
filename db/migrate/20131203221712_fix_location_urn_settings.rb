class FixLocationUrnSettings < ActiveRecord::Migration
  def up
    Website.all.each do |website|
      website.settings.where(name: "location_urn").each do |location_urn_setting|
        location_urn_setting.update_attribute(:value, website.location.urn)
      end
    end
  end

  def down
  end
end
