require "static_website/compiler/javascript"
require "static_website/compiler/file_concatenator"

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

          file_concatenator.compile
        end
      end

      def compile_javascript(javascript_path)
        if javascript_path
          javascript = Javascript.new(javascript_path, compile_path)
          javascript.compile
          @js_paths << javascript.js_path
        end
      end

      def file_concatenator
        @file_concatenator ||= FileConcatenator.new(js_paths, concatenated_path)
      end

      def concatenated_path
        @concatenated_path ||= File.join(compile_path, "javascripts", "application.js")
      end

      def concatenated_link_path
        @concatenated_link_path ||= File.join("/javascripts", "application.js")
      end
    end
  end
end
