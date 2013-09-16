namespace :websites do
  desc "seeds websites"
  task :seed => :environment do
    Resque.enqueue(WebsitesSeeder)
  end
end
