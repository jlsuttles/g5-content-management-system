module StaticWebsite
  module Compiler
    class HTAccess

      def initialize(website, web_template_models)
        @website_compile_path = website.compile_path
        @web_template_models = web_template_models
      end

      def compile_path
        File.join(@website_compile_path.to_s, ".htaccess")
      end

      def compile
        compile_directory.compile
        render_to_file
      end

      def compile_directory
        @compile_directory ||= CompileDirectory.new(compile_path, false)
      end

      def render_htaccess
        redirects = []

        @web_template_models.each do |web_template_model|
          redirect = "\tRewriteRule ^#{web_template_model.slug}.html /#{File.join(web_template_model.client.vertical_slug, web_template_model.location.state_slug, web_template_model.location.city_slug, web_template_model.slug, "index.html")}/ [R=301,L]"

          redirects << redirect
        end if @web_template_models

        htaccess_contents = ["<IfModule mod_rewrite.c>",
                            "\tRewriteEngine On",
                            redirects,
                            "\tRewriteCond %{REQUEST_FILENAME} !-d",
                            "\tRewriteCond %{REQUEST_FILENAME} !-f",
                            "\tRewriteRule ^(.*)$ index.php?/$1 [QSA,L]",
                            "</IfModule>"]

        return htaccess_contents.flatten.join("\n")
      end

      private

      def render_to_file
        open(compile_path, "wb") do |file|
          file << render_htaccess
        end if compile_path
      end
    end
  end
end
