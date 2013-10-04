class WebsitesSeeder
  extend HerokuResqueAutoscaler if Rails.env.production?
  @queue = :seeder

  def self.perform
    Location.all.each do |location|
      self.new(location).perform
    end
  end

  def initialize(location)
    @location = location
  end

  def perform(location)
    DefaultWebsiteSeeder.new(@location).seed
  end
end
