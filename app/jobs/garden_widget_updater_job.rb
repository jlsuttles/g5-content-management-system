class GardenWidgetUpdaterJob
  extend HerokuResqueAutoscaler if Rails.env.production?
  @queue = :garden_widget_updater

  def self.perform
    GardenWidgetUpdater.new.update_all
  end
end
clas
