require "open-uri"

class RemoteSassFile
  def initialize(sass_file_path)
    @sass_file_path = sass_file_path
    write_to_public_stylesheets_sass
    compile_to_public_stylesheets
  end

  def sass_file_path
    @sass_file_path
  end

  def file_name
    @file_name ||= sass_file_path.split("/").last.split(".").first
  end

  def sass_file_name
    @sass_file_name ||= "#{file_name}.scss"
  end

  def css_file_name
    @css_file_name ||= "#{file_name}.css"
  end

  def public_css_path
    @public_css_path ||= File.join(Rails.root, "public", "stylesheets")
  end

  def public_sass_path
    @public_sass_path ||= File.join(public_css_path, "sass")
  end

  def public_css_file_path
    @public_css_file_path ||= File.join(public_css_path, css_file_name)
  end

  def public_sass_file_path
    @public_sass_file_path ||= File.join(public_sass_path, sass_file_name)
  end

  def css_path
    @css_path ||= File.join("/stylesheets", css_file_name)
  end

  def write_to_public_stylesheets_sass
    FileUtils.mkdir_p(public_sass_path)
    open(public_sass_file_path, "wb") do |file|
      file << open(sass_file_path).read
    end
  end

  def compile_to_public_stylesheets
    Sass.compile_file(public_sass_file_path, public_css_file_path)
  end
end
