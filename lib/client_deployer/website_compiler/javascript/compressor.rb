require "client_deployer/compile_directory"
require "uglifier"

module ClientDeployer
  module WebsiteCompiler
    class Javascript
      class Compressor
        attr_reader :file_paths, :compile_path, :compressor

        def initialize(file_paths, compile_path)
          @file_paths = file_paths
          @compile_path = compile_path
          @compressor ||= Uglifier.new(comments: :none)
        end

        def compile
          File.delete(compile_path) if File.exists?(compile_path)
          compile_directory.compile
          compress
        end

        def compile_directory
          @compile_directory ||= ClientDeployer::CompileDirectory.new(compile_path, false)
        end

        def compress
          open(compile_path, "w") do |file|
            file.write compressor.compile(concatenate)
          end if compile_path
        end

        def concatenate
          file_paths.map do |file_path|
            if File.exists?(file_path)
              js = open(file_path).read
              File.delete(file_path)
              js
            end
          end.join("\n")
        end
      end
    end
  end
end
