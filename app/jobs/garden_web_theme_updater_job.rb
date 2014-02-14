class GardenWebThemeUpdaterJob
  extend HerokuResqueAutoscaler if Rails.env.production?
  @queue = :garden_web_theme_updater

  def self.perform
    GardenWebThemeUpdater.new.update_all
  end
end
