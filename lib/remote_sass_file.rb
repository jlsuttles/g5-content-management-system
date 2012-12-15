require "open-uri"

class RemoteSassFile
  def initialize(remote_path, colors, compile_path=nil)
    @remote_path = remote_path
    @colors = colors
    @compile_path = compile_path
  end

  def local_file
    @local_file ||= Tempfile.new(sass_file_name)
  end

  def local_path
    @local_path ||= local_file.path
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

  def colors_dir
    @colors_dir ||= File.join(Rails.root, "tmp", "colors", SecureRandom.hex)
  end

  def colors_path
    @colors_path ||= File.join(colors_dir, "colors.scss")
  end

  def compile
    begin
      save_locally
      save_colors
      sass_compile_file
    ensure
      local_file.close
      local_file.unlink
      FileUtils.rm_rf(colors_dir)
    end
  end

  def save_locally
    open(local_path, "wb") do |file|
      file << open(@remote_path).read
    end
  end
  
  def save_colors
    FileUtils.mkdir_p(colors_dir)
    open(colors_path, "wb") do |file|
      file << PagesController.new.render_to_string(
      "pages/colors",
      formats: [:scss],
      layout:  false,
      locals:  { 
        primary_color: @colors[:primary],
        secondary_color: @colors[:secondary]
      })
    end
  end

  def sass_compile_file
    Sass.load_paths << colors_dir
    Sass.compile_file(local_path, compiled_file_path, syntax: :scss)
    open(compiled_file_path).read
  end
end
