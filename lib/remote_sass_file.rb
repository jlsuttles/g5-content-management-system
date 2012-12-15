require "open-uri"

class RemoteSassFile
  def initialize(remote_path, compile_path=nil)
    @remote_path = remote_path
    @compile_path = compile_path
  end

  def local_path
    @local_path ||= Tempfile.new(sass_file_name).path
  end

  def file_name
    @file_name ||= @remote_path.split("/").last.split(".").first
  end

  def sass_file_name
    @sass_file_name ||= "#{file_name}.scss"
  end

  def css_file_name
    @css_file_name ||= "#{file_name}.css"
  end

  def compile_path
    @compile_path ||= File.join(Rails.root, "public", "stylesheets")
  end

  def compiled_file_path
    @compiled_file_path ||= File.join(compile_path, css_file_name)
  end

  def stylesheet_link_path
    @stylesheet_link_path ||= File.join("/stylesheets", css_file_name)
  end

  def compile
    save_locally
    sass_compile_file
  end

  def save_locally
    open(local_path, "wb") do |file|
      file << open(@remote_path).read
    end
  end

  def sass_compile_file
    Sass.compile_file(local_path, compiled_file_path)
  end
end
