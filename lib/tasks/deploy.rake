namespace :deploy do
  desc "enqueues post deploy tasks"
  task :tasks => :environment do
    Resque.enqueue(DeployTasks, ENV["G5_CLIENT_UID"])
    Resque.enqueue(SiblingConsumer)
  end
end
