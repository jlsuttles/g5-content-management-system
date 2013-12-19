class DeployTasks
  extend HerokuResqueAutoscaler if Rails.env.production?
  @queue = :deploy_tasks

  def self.perform(client_uid)
    # ClientReader must be performed before WebsiteSeeder
    ClientReaderJob.perform(client_uid)
    WebsiteSeederJob.perform
  end
end
