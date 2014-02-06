class AddAndUpdateWidgetSettings < ActiveRecord::Migration
  def up
    client_services = ClientServices.new
    client = client_services.client

    Website.all.each do |website|
      website.settings.find_or_create_by_name!(name: "client_url", value: client_services.client_url)
      website.settings.find_or_create_by_name!(name: "client_location_urns", value: client_services.client_location_urns)
      website.settings.find_or_create_by_name!(name: "client_location_urls", value: client_services.client_location_urls)
      website.settings.find_or_create_by_name!(name: "location_url", value: website.location.domain)

      ClientServices::SERVICES.each do |service|
        %w(urn url).each do |suffix|
          setting_name = [service, suffix].join("_")
          website.settings.find_or_create_by_name!(name: setting_name, value: client_services.public_send(setting_name.to_sym))
        end
      end
    end
  end

  def down
  end
end
