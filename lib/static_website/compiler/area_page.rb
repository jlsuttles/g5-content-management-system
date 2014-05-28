module StaticWebsite
  module Compiler
    class AreaPage
      def initialize(base_path, slug)
        @base_path = base_path
        @slug = slug
      end

      def compile
        compile_directory.compile
        render_to_file
      end

    private

      def compile_path
        File.join(@base_path.to_s, @slug, "index.html")
      end

      def compile_directory
        @compile_directory ||= CompileDirectory.new(compile_path, false)
      end

      def render_to_file
        open(compile_path, "wb") do |file|
          file << "Foo"
        end if compile_path
      end
    end
  end
end
