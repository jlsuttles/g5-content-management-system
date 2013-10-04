class DeployTasks
  extend HerokuResqueAutoscaler if Rails.env.production?
  @queue = :deploy

  def self.perform(client_uid)
    # ClientReader must be performed before WebsiteSeeder
    ClientReader.perform(client_uid)
    WebsitesSeeder.perform
  end
end
