require "client_deployer/website_compiler"
require "static_website/deployer"

module ClientDeployer
  class Deployer < StaticWebsite::Deployer
    def initialize(client)
      @website = client.website.decorate
      @compile_path = website.compile_path
      @retries = 0
    end
  end
end
