namespace :deploy do
  desc "enqueues post deploy tasks"
  task :tasks => :environment do
    Resque.enqueue(ClientReaderAndWebsitesSeeder, ENV["G5_CLIENT_UID"])
    Resque.enqueue(SiblingConsumer)
  end
end
