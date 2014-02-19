require "static_website/compiler/stylesheet"
require "static_website/compiler/stylesheet/colors"
require "static_website/compiler/file_concatenator"

module StaticWebsite
  module Compiler
    class Stylesheets
      attr_reader :stylesheet_paths, :compile_path, :colors, :link_paths, :css_paths

      def initialize(stylesheet_paths, compile_path, colors={})
        @stylesheet_paths = stylesheet_paths
        @compile_path = compile_path
        @colors = colors
        @css_paths = []
        @link_paths = []
      end

      def compile
        @css_paths = []
        @link_paths = []
        if stylesheet_paths
          colors_stylesheet.compile

          stylesheet_paths.each do |stylesheet|
            compile_stylesheet(stylesheet)
          end

          file_concatenator.compile
        end
      end

      def colors_stylesheet
        @colors_stylesheet ||= Stylesheet::Colors.new(colors, compile_path)
      end

      def compile_stylesheet(stylesheet_path)
        if stylesheet_path
          stylesheet = Stylesheet.new(stylesheet_path, compile_path)
          stylesheet.compile
          @css_paths << stylesheet.css_path
          @link_paths << stylesheet.link_path
        end
      end

      def file_concatenator
        @file_concatenator ||= FileConcatenator.new(css_paths, concatenated_path)
      end

      def concatenated_path
        @concatenated_path ||= File.join(compile_path, "stylesheets", "application.css")
      end

      def concatenated_link_path
        @concatenated_link_path ||= File.join("/stylesheets", "application.css")
      end
    end
  end
end
