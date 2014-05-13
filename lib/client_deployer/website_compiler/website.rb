require "static_website/compiler/compile_directory"
require "static_website/compiler/javascripts"
require "static_website/compiler/stylesheets"
require "static_website/compiler/web_template"
require "static_website/compiler/web_templates"

module ClientDeployer
  module WebsiteCompiler
    class Website
      def initialize(website)
        @website = website
        @compile_path = website.compile_path
      end

      def compile
        compile_directory.compile
        javascripts.compile
        stylesheets.compile
        web_home_template.compile
        web_page_templates.compile
      end

    private

      def compile_directory
        StaticWebsite::Compiler::CompileDirectory.new(@compile_path, false)
      end

      def javascripts
        StaticWebsite::Compiler::Javascripts.new(@website.javascripts, @compile_path, location_name)
      end

      def stylesheets
        StaticWebsite::Compiler::Stylesheets.new(@website.stylesheets, @compile_path, @website.colors, location_name)
      end

      def web_home_template
         StaticWebsite::Compiler::WebTemplate.new(@website.web_home_template)
      end

      def web_page_templates
        StaticWebsite::Compiler::WebTemplates.new(@website.web_page_templates)
      end

      def location_name
        @website.name
      end
    end
  end
end
