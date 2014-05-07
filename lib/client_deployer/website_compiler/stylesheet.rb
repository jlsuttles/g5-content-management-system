require "client_deployer/compile_directory"
require "client_deployer/website_compiler/remote_file"
require "client_deployer/website_compiler/stylesheet/scss"

module ClientDeployer
  module WebsiteCompiler
    class Stylesheet
      attr_reader :stylesheet_path, :compile_path

      def initialize(stylesheet_path, compile_path)
        @stylesheet_path = stylesheet_path
        @compile_path = File.join(compile_path, "stylesheets", filename) if compile_path
      end

      def compile
        compile_directory.compile
        remote_stylesheet.compile
        scss_stylesheet.compile
      end

      def compile_directory
        @compile_directory ||= ClientDeployer::CompileDirectory.new(compile_path, false)
      end

      def remote_stylesheet
        @remote_stylesheet ||= RemoteFile.new(stylesheet_path, scss_path)
      end

      def scss_stylesheet
        @scss_stylesheet ||= Stylesheet::Scss.new(scss_path, css_path)
      end

      def scss_path
        "#{compile_path}.scss"
      end

      def css_path
        "#{compile_path}.css"
      end

      def filename
        @filename ||= "#{stylesheet_path.split("/").last.split(".").first}_#{SecureRandom.hex(3)}"
      end

      def link_path
        @link_path ||= "/stylesheets/#{filename}.css"
      end
    end
  end
end
