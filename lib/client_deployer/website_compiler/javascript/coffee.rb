require "client_deployer/compile_directory"

module ClientDeployer
  module WebsiteCompiler
    class Javascript
      class Coffee
        attr_reader :javascript_path, :compile_path

        def initialize(javascript_path, compile_path)
          @javascript_path = javascript_path
          @compile_path = compile_path
        end

        def compile
          compile_directory.compile
          render_to_file
        end

        def compile_directory
          @compile_directory ||= ClientDeployer::CompileDirectory.new(compile_path, false)
        end

        private

        def render_to_file
          open(compile_path, "wb") do |file|
            file << CoffeeScript.compile(File.read(javascript_path))
          end if compile_path
        end
      end
    end
  end
end
