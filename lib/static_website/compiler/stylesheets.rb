require "static_website/compiler/stylesheet"
require "static_website/compiler/stylesheet/colors"

module StaticWebsite
  module Compiler
    class Stylesheets
      attr_reader :stylesheet_paths, :compile_path, :colors, :link_paths

      def initialize(stylesheet_paths, compile_path, colors={})
        @stylesheet_paths = stylesheet_paths
        @compile_path = compile_path
        @colors = colors
        @link_paths = []
      end

      def compile
        @link_paths = []
        if stylesheet_paths
          colors_stylesheet.compile

          stylesheet_paths.each do |stylesheet|
            compile_stylesheet(stylesheet)
          end
        end
      end

      def colors_stylesheet
        @colors_stylesheet ||= Stylesheet::Colors.new(colors, compile_path)
      end

      def compile_stylesheet(stylesheet_path)
        if stylesheet_path
          stylesheet = Stylesheet.new(stylesheet_path, compile_path)
          stylesheet.compile
          @link_paths << stylesheet.link_path
        end
      end
    end
  end
end
