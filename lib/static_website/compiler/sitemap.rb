module StaticWebsite
  module Compiler
    class Sitemap

      def initialize(website)
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
        urls = []

        # Web Home Template
        loc        = "\n\t\t<loc>#{File.join(@web_home_template.location_domain)}</loc>"
        lastmod    = "\n\t\t<lastmod>#{@web_home_template.last_mod}</lastmod>"
        changefreq = "\n\t\t<changefreq>weekly</changefreq>"
        priority   = "\n\t\t<priority>0.9</priority>"

        web_home_template = "\t<url>" + loc + lastmod + changefreq + priority + "\n\t</url>"

        urls << web_home_template

        # Web Page Templates
        @web_page_templates.each do |template|
          if @web_home_template && template.enabled
            loc        = "\n\t\t<loc>#{File.join(@web_home_template.location_domain, @web_home_template.client.vertical_slug, @web_home_template.location.state_slug, @web_home_template.location.city_slug)}/#{template.slug}</loc>"
            lastmod    = "\n\t\t<lastmod>#{template.last_mod}</lastmod>"
            changefreq = "\n\t\t<changefreq>weekly</changefreq>"
            priority   = "\n\t\t<priority>0.7</priority>"

            web_page_template = "\t<url>" + loc + lastmod + changefreq + priority + "\n\t</url>"

            urls << web_page_template
          end
        end

        sitemap_contents = ["<?xml version='1.0' encoding='UTF-8'?>",
                            "<urlset xmlns='http://www.sitemaps.org/schemas/sitemap/0.9'>",
                            urls,
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
