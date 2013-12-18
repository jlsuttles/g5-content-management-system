class ClientReader
  extend HerokuResqueAutoscaler if Rails.env.production?
  @queue = :reader

  def self.perform(client_uid)
<<<<<<< HEAD
    clients = Microformats2.parse(client_uid)
<<<<<<< HEAD
    client = clients.first

    Client.destroy_all
    Client.create!(
      uid: client_uid,
      name: client.name.to_s,
      vertical: client.g5_vertical.to_s
    )

    Location.destroy_all
    client.orgs.each do |location|
      location = location.format
      Location.create!(
        uid: location.uid.to_s,
        urn: location.uid.to_s.split("/").last,
        name: location.name.to_s,
        city: location.adr.try(:format).try(:locality).to_s,
        street_address: location.adr.try(:format).try(:street_address).to_s,
        state: location.adr.try(:format).try(:region).to_s,
        postal_code: location.adr.try(:format).try(:postal_code).to_s
      )
    end if client.respond_to?(:orgs)
=======
    first_client = clients.first

    client = Client.find_or_create_by_uid(uid: client_uid)

    client.uid = client_uid
    client.name = first_client.name.to_s
    client.vertical = first_client.g5_vertical.to_s

    client.save

    first_client.orgs.each do |org|
      org = org.format

      location = Location.find_or_create_by_uid(uid: org.uid.to_s)

      location.uid = org.uid.to_s
      location.urn = org.uid.to_s.split("/").last
      location.name = org.name.to_s
      location.state = org.adr.try(:format).try(:region).to_s
      location.city = org.adr.try(:format).try(:locality).to_s

      location.save
    end if first_client.respond_to?(:orgs)
>>>>>>> update client & location in client_reader instead of destroying
=======
    uf2_client = Microformats2.parse(client_uid).first

    current_client = Client.first

    if current_client && current_client.uid != client_uid
      current_client.destroy
    else
      Client.find_or_create_by_uid(
        uid: client_uid,
        name: uf2_client.name.to_s,
        vertical: uf2_client.g5_vertical.to_s
      )
    end

    current_locations = Locations.all
    uf2_location_uids = []

    uf2_client.orgs.each do |location|

      uf2_location = uf2_location.format
      uf2_location_uids << uf2_location.uid.to_s

       Location.find_or_create_by_uid(
        uid: uf2_location.uid.to_s,
        urn: uf2_location.uid.to_s.split("/").last,
        name: uf2_location.name.to_s,
        state: uf2_location.adr.try(:format).try(:region).to_s,
        city: uf2_location.adr.try(:format).try(:locality).to_s
      )
    end if uf2_client.respond_to?(:orgs)

    current_locations.each do |current_location|
     unless uf2_location_uids.include? current_location.uid
      current_location.destroy
     end
    end
>>>>>>> Create or update clients and locations
  end
end
