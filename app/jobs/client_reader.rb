class ClientReader
  extend HerokuResqueAutoscaler if Rails.env.production?
  @queue = :reader

  def self.perform(client_uid)
    clients = Microformats2.parse(client_uid)
    client = clients.first

    Client.destroy_all
    Client.create!(
      uid: client_uid,
      name: client.name.to_s
    )

    Location.destroy_all
    client.orgs.each do |location|
      location = location.format
      Location.create!(
        uid: location.uid.to_s,
        name: location.name.to_s
      )
    end if client.respond_to?(:orgs)
  end
end
