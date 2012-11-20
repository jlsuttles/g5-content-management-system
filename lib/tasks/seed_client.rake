task "seed_client" => :environment do
  G5ClientHub::ClientReader.perform(ENV["G5_CLIENT_UID"])
end
