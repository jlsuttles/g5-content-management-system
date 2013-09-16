namespace :client do
  desc "seeds client"
  task :consume => :environment do
    Resque.enqueue(ClientReader, ENV["G5_CLIENT_UID"])
  end
end
