class ClientDeployerJob
  extend HerokuResqueAutoscaler if Rails.env.production?
  @queue = :static_website_deployer

  def self.perform
    new.perform
  end

  def perform
    ClientDeployer.compile_and_deploy(Client.first)
  end
end
