task "seed_client" => :environment do
  # http://g5-hub.herokuapp.com/clients/9
  G5ClientHub::ClientReader.perform(ENV["G5_CLIENT_UID"])
end
