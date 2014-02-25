require "static_website/compiler/stylesheet"
require "static_website/compiler/stylesheet/colors"
require "static_website/compiler/stylesheet/compressor"

module StaticWebsite
  module Compiler
    class Stylesheets
      attr_reader :stylesheet_paths, :compile_path, :colors, :location_name,
        :preview, :css_paths, :link_paths

      def initialize(stylesheet_paths, compile_path, colors={}, location_name="", preview=false)
        @stylesheet_paths = stylesheet_paths.try(:compact).try(:uniq)
        @compile_path = compile_path
        @colors = colors
        @location_name
        @preview = preview
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

          stylesheet_compressor.compile unless preview
          stylesheet_uploader.compile unless preview
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

      def stylesheet_compressor
        @stylesheet_compressor ||= Stylesheet::Compressor.new(css_paths, compressed_path)
      end

      def compressed_path
        @compressed_path ||= File.join(compile_path, "stylesheets", "application.min.css")
      end

      def stylesheet_uploader
        @stylesheet_uploader ||= Stylesheet::Uploader.new(compressed_path, location_name)
      end

      def uploaded_path
        @uploaded_path ||= stylesheet_uploader.uploaded_path
      end
    end
  end
end
