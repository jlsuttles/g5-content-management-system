class GardenWebLayoutUpdaterJob
  extend HerokuResqueAutoscaler if Rails.env.production?
  @queue = :garden_web_layout_updater

  def self.perform
    GardenWebLayoutUpdater.new.update_all
  end
end
