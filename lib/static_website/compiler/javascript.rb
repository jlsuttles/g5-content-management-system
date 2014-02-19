require "static_website/compiler/compile_directory"
require "static_website/compiler/remote_file"
require "static_website/compiler/javascript/coffee"

module StaticWebsite
  module Compiler
    class Javascript
      attr_reader :javascript_path, :compile_path

      def initialize(javascript_path, compile_path)
        @javascript_path = javascript_path
        @compile_path = File.join(compile_path, "javascripts", "#{filename}.js") if compile_path
      end

      def compile
        compile_directory.compile
        remote_javascript.compile
        coffee_javascript.compile
      end

      def compile_directory
        @compile_directory ||= CompileDirectory.new(compile_path, false)
      end

      def remote_javascript
        @remote_javascript ||= RemoteFile.new(javascript_path, compile_path)
      end

      def coffee_javascript
        @coffee_javascript ||= Javascript::Coffee.new(compile_path, compile_path)
      end

      def js_path
        compile_path
      end

      def filename
        @filename ||= javascript_path.split("/").last.split(".").first
      end

      def link_path
        @link_path ||= "/javascripts/#{filename}.js"
      end
    end
  end
end
