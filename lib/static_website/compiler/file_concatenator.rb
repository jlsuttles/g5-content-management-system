require "static_website/compiler/compile_directory"

module StaticWebsite
  module Compiler
    class FileConcatenator
      attr_reader :file_paths, :compile_path

      def initialize(file_paths, compile_path)
        @file_paths = file_paths
        @compile_path = compile_path
      end

      def compile
        compile_directory.compile
        concatenate
      end

      def compile_directory
        @compile_directory ||= CompileDirectory.new(compile_path, false)
      end

      def concatenate
        open(compile_path, "wb") do |file|
          file_paths.uniq.each do |file_path|
            if File.exists?(file_path)
              file << open(file_path).read
              File.delete(file_path)
            end
          end
        end if compile_path
      end
    end
  end
end
