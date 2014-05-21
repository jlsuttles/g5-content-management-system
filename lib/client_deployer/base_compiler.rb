require "client_deployer/base_compiler/base_files"

module ClientDeployer::BaseCompiler
  def self.new(client)
    ClientDeployer::BaseCompiler::BaseFiles.new(client)
  end
end
