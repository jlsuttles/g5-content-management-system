require "static_website/compiler/javascript"
require "static_website/compiler/javascript/compressor"

module StaticWebsite
  module Compiler
    class Javascripts
      attr_reader :javascript_paths, :compile_path, :js_paths

      def initialize(javascript_paths, compile_path)
        @javascript_paths = javascript_paths.try(:compact).try(:uniq)
        @compile_path = compile_path
        @js_paths =[]
      end

      def compile
        @js_paths = []
        if javascript_paths
          javascript_paths.each do |javascript_path|
            compile_javascript(javascript_path)
          end
          javascript_compressor.compile
        end
      end

      def compile_javascript(javascript_path)
        if javascript_path
          javascript = Javascript.new(javascript_path, compile_path)
          javascript.compile
          @js_paths << javascript.js_path
        end
      end

      def javascript_compressor
        @javascript_compressor ||= Javascript::Compressor.new(js_paths, compressed_path)
      end

      def compressed_path
        @compressed_path ||= File.join(compile_path, "javascripts", "application.min.js")
      end

      def compressed_link_path
        @compressed_link_path ||= File.join("/javascripts", "application.min.js")
      end
    end
  end
end
