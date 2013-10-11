require "static_website/compiler/compile_directory"
require "open-uri"

module StaticWebsite
  module Compiler
    class RemoteFile
      attr_reader :remote_path, :compile_path

      def initialize(remote_path, compile_path)
        @remote_path = remote_path
        @compile_path = compile_path
      end

      def compile
        compile_directory.compile
        write_to_file
      end

      def compile_directory
        @compile_directory ||= CompileDirectory.new(compile_path, false)
      end

      private

      def write_to_file
        open(compile_path, "wb") do |file|
          file << open(remote_path).read
        end if compile_path
      end
    end
  end
end
