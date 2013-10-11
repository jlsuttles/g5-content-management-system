require "static_website/compiler/javascript"

module StaticWebsite
  module Compiler
    class Javascripts
      attr_reader :javascript_paths, :compile_path

      def initialize(javascript_paths, compile_path)
        @javascript_paths = javascript_paths
        @compile_path = compile_path
      end

      def compile
        javascript_paths.each do |javascript_path|
          compile_javascript(javascript_path)
        end if javascript_paths
      end

      def compile_javascript(javascript_path)
        Javascript.new(javascript_path, compile_path).compile if javascript_path
      end
    end
  end
end
