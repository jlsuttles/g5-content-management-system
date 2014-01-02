module StaticWebsite
  module Compiler
    class Sitemap

      def initialize(website)
        @heroku_app = "http://#{WebsiteDecorator.decorate(website).heroku_app_name}.herokuapp.com"
        @website_compile_path = website.compile_path
        @web_home_template = website.web_home_template
        @web_page_templates = website.web_page_templates
      end

      def compile_path
        File.join(@website_compile_path.to_s, "sitemap.xml")
      end

      def compile
        compile_directory.compile
        render_to_file
      end

      def compile_directory
        @compile_directory ||= CompileDirectory.new(compile_path, false)
      end

      def render_sitemap
        sitemap_pages = []
        templates = (@web_page_templates + [@web_home_template]).compact

        templates.each do |template|
          if @web_home_template && template.enabled
            sitemap_pages << "\t<url>\n\t\t<loc>#{File.join(@heroku_app, @web_home_template.client.vertical_slug, @web_home_template.location.state_slug, @web_home_template.location.city_slug)}/#{template.slug}</loc>\n\t</url>"
          end
        end

        sitemap_contents = ["<?xml version='1.0' encoding='UTF-8'?>",
                            "<urlset xmlns='http://www.sitemaps.org/schemas/sitemap/0.9'>",
                            "\t<url>\n\t\t<loc>#{File.join(@heroku_app)}</loc>\n\t</url>",
                            sitemap_pages,
                            "</urlset>"]

        return sitemap_contents.flatten.join("\n")
      end

      private

      def render_to_file
        open(compile_path, "wb") do |file|
          file << render_sitemap
        end if compile_path
      end
    end
  end
end
