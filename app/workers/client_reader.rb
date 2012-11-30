class ClientReader
  extend HerokuResqueAutoscaler if Rails.env.production?
  @queue = :reader

  def self.perform(client_uid)
    clients = G5HentryConsumer::EG5Client.parse(client_uid)
    client = clients.first

    Client.destroy_all
    Client.create!(
      uid: client_uid,
      name: client.name.first
    )

    Location.destroy_all
    client.locations.each do |location|
      Location.create!(
        uid: location.uid,
        name: location.name.first
      )
    end if client.locations

    Feature.destroy_all
    client.features.each do |feature|
      Feature.create!(
        uid: feature.uid,
        name: feature.name.first
      )
    end if client.features
  end
end
