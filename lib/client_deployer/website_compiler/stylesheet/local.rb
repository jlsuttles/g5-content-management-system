require "client_deployer/website_compiler/view"

module ClientDeployer
  module WebsiteCompiler
    class Stylesheet
      class Local
        attr_reader :colors, :compile_path

        def initialize(colors, compile_path)
          @colors = colors || {}
          @compile_path = File.join(compile_path, "stylesheets", "colors.css") if compile_path
        end

        def compile
          view.compile
        end

        def view
          @view ||= View.new(view_path, view_options, compile_path)
        end

        def view_path
          "web_templates/stylesheets"
        end

        def options
          { syntax: :scss,
            load_paths: [compile_directory.path] }
        end

        private

        def render_to_file
          open(compile_path, "wb") do |file|
            file << Sass::Engine.new(open(stylesheet_path).read, options).render
          end if compile_path
        end
    end
  end
end
