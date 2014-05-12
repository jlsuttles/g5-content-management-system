require "client_deployer/compile_directory"
require "client_deployer/website_compiler/remote_file"
require "client_deployer/website_compiler/javascript/coffee"

module ClientDeployer
  module WebsiteCompiler
    class Javascript
      attr_reader :javascript_path, :compile_path

      def initialize(website, javascript_path, compile_path)
        @website = website
        @javascript_path = javascript_path
        @root_path = compile_path.split("/")[0...-1].join("/")
        @compile_path = File.join(compile_path, "javascripts", filename) if compile_path
      end

      def compile
        compile_directory.compile
        remote_javascript.compile
        coffee_javascript.compile
      end

      def compile_directory
        @compile_directory ||= ClientDeployer::CompileDirectory.new(compile_path, false)
      end

      def remote_javascript
        @remote_javascript ||= RemoteFile.new(javascript_path, js_path)
      end

      def coffee_javascript
        @coffee_javascript ||= Javascript::Coffee.new(js_path, js_path)
      end

      def js_path
        "#{compile_path}.js"
      end

      def filename
        @filename ||= "#{javascript_path.split("/").last.split(".").first}_#{SecureRandom.hex(3)}"
      end

      def include_path
        @include_path ||= "/javascripts/#{filename}.js"
      end
    end
  end
end
