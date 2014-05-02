class ClientReader
  def initialize(client_uid)
    @client_uid = client_uid
  end

  def perform
    # Use the provided client UID to grab the microformats2 representation of
    # the client, which is located at the client UID, which is a URL.
    uf2_client = Microformats2.parse(@client_uid).first

    # Grab the first client out of the database. There should only be one.
    current_client = Client.first

    # If the current client in the database has a different UID than the one we
    # are trying to seed from, destroy all clients because we only expect there
    # to be one in the database and we are about to create a new one.
    Client.destroy_all if current_client && current_client.uid != @client_uid

    # So now either there is a client in the database with the UID we want or
    # there are no clients in the database. So we either update the existing
    # client or create a new one.
    client = Client.find_or_initialize_by_uid(uid: @client_uid)
    client.name     = uf2_client.name.to_s
    client.vertical = uf2_client.g5_vertical.to_s

    client.save

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

      location = Location.find_or_initialize_by_uid(uid: uf2_location.uid.to_s)
      location.urn            = uf2_location.uid.to_s.split("/").last
      location.name           = uf2_location.name.to_s
      location.domain         = uf2_location.g5_domain.to_s
      location.street_address = uf2_location.adr.try(:format).try(:street_address).to_s
      location.state          = uf2_location.adr.try(:format).try(:region).to_s
      location.city           = uf2_location.adr.try(:format).try(:locality).to_s
      location.neighborhood   = uf2_location.adr.try(:format).try(:neighborhood).to_s
      location.postal_code    = uf2_location.adr.try(:format).try(:postal_code).to_s
      location.phone_number   = uf2_location.adr.try(:format).try(:tel).to_s

      location.save
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
  end
end
