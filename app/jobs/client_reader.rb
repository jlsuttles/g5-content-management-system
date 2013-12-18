class ClientReader
  extend HerokuResqueAutoscaler if Rails.env.production?
  @queue = :reader

  def self.perform(client_uid)
<<<<<<< HEAD
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
=======
    # Use the provided client UID to grab the microformats2 representation of
    # the client, which is located at the client UID, which is a URL.
>>>>>>> Adds lots of comments to describe what the client reader is doing
    uf2_client = Microformats2.parse(client_uid).first

    # Grab the first client out of the database. There should only be one.
    current_client = Client.first

    # If the current client in the database has a different UID than the one we
    # are trying to seed from, destroy all clients because we only expec their
    # to be one in the database and we are about to create a new one.
    Client.destroy_all if current_client && current_client.uid != client_uid

    # So now either there is a client in the database with the UID we want or
    # there are no clients in the database. So we either update the existing
    # client or create a new one.
    Client.find_or_create_by_uid(
      uid: client_uid,
      name: uf2_client.name.to_s,
      vertical: uf2_client.g5_vertical.to_s
    )

    # Grab all of the current locations out of the database.
    current_locations = Location.all
    # Start a list of the location UIDs that are part of the microformats2
    # represtation of the client. We will use this later to clean up locations
    # from the database that should not be there.
    uf2_location_uids = []

    # Start looping through each microformats2 representation of locations.
    uf2_client.orgs.each do |uf2_location|

      # We want the nested format version of the micorformats2 location.
      uf2_location = uf2_location.format
      # Save the microformats2 location uid. We will use this later to clean up
      # locations from the database that should not be there.
      uf2_location_uids << uf2_location.uid.to_s

      # Update an existing location if the one with UID we want is already in
      # the database or create a new one.
      Location.find_or_create_by_uid(
        uid: uf2_location.uid.to_s,
        urn: uf2_location.uid.to_s.split("/").last,
        name: uf2_location.name.to_s,
        state: uf2_location.adr.try(:format).try(:region).to_s,
        city: uf2_location.adr.try(:format).try(:locality).to_s
      )
    end if uf2_client.respond_to?(:orgs)

    # Now we need to clean up locations that are in the database that shouldn't
    # be. This should basically only happen when a new different client was
    # seeded ontop of another one (so all the locations are different) or a
    # location was removed from a client.
    current_locations.each do |current_location|
     unless uf2_location_uids.include? current_location.uid
      current_location.destroy
     end
    end
>>>>>>> Create or update clients and locations
  end
end
