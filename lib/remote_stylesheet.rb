require "open-uri"

class RemoteStylesheet
  def initialize(remote_path, colors=nil, css_dir=nil)
    @remote_path = remote_path
    @colors = colors || { primary: "#000000", secondary: "#ffffff" }
    @css_dir = css_dir || File.join(Rails.root, "public", "stylesheets")
  end

  def file_name
    @file_name ||= @remote_path.split("/").last.split(".").first
  end

  def scss_file_name
    @scss_file_name ||= "#{file_name}.scss"
  end

  def css_dir
    @css_dir
  end

  def css_file_name
    @css_file_name ||= "#{file_name}.css"
  end

  def css_file_path
    @css_file_path ||= File.join(css_dir, css_file_name)
  end

  def css_link_path
    @css_link_path ||= File.join("/stylesheets", css_file_name)
  end

  def colors_dir
    @colors_dir ||= File.join(Rails.root, "tmp", "colors", SecureRandom.hex)
  end

  def colors_path
    @colors_path ||= File.join(colors_dir, "colors.scss")
  end

  def compile
    begin
      compile_colors
      compile_self
    ensure
      FileUtils.rm_rf(colors_dir)
    end
  end

  def compile_colors
    FileUtils.mkdir_p(colors_dir)
    open(colors_path, "wb") do |file|
      file << PagesController.new.render_to_string(
      "compiled_pages/stylesheets/colors",
      formats: [:scss],
      layout:  false,
      locals:  { 
        primary_color: @colors[:primary],
        secondary_color: @colors[:secondary]
      })
    end
    open(colors_path).read
  end

  def compiled_pages_stylesheets_dir
    @compiled_pages_stylesheets_dir ||= File.join(Rails.root, "app", "views", "compiled_pages", "stylesheets")
  end

  def compile_self
    FileUtils.mkdir_p(css_dir)
    options = { syntax: :scss, load_paths: [colors_dir, compiled_pages_stylesheets_dir] }
    open(css_file_path, "wb") do |file|
      file << Sass::Engine.new(open(@remote_path).read, options).render
    end
    open(css_file_path).read
  end
end
