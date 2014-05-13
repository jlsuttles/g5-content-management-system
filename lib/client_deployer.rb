require "static_website/compiler/compile_directory"
require "client_deployer/base_compiler"
require "client_deployer/website_compiler"
require "client_deployer/deployer"

module ClientDeployer
  def self.compile_and_deploy(client)
    ClientDeployer::BaseCompiler.new(client).compile
    compile_location_websites
    ClientDeployer::Deployer.new(client).deploy
    cleanup(client.website.compile_path)
  end

  def self.compile_location_websites
    Website.location_websites.each { |website| compile(website) }
  end

  def self.compile(website)
    WebsiteCompiler.new(website).compile
  end

  def self.cleanup(compile_path)
    StaticWebsite::Compiler::CompileDirectory.new(compile_path, false).clean_up
  end
end
