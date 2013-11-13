namespace :ember do
  desc "generates fixtures for Ember"
  task :fixtures => :environment do
    EmberFixtureGenerator.generate
  end
end
