class RemoteSassFile
  def initialize(file_path)
    @file_path = file_path
  end

  # The path of the uncompiled Sass file,
  # i.e. http://g5-layout-garden.herokuapp.com/static/components/main-first-sidebar-left/stylesheets/layout-side-left.scss
  def sass_file_path
    @file_path
  end

  # The file name of the uncompiled Sass file,
  # i.e. layout-side-left
  def sass_file_name
    @sass_file_name ||= sass_file_path.split("/").last.split(".").first
  end

  # The path of the compiled css
  # i.e. tmp/stylesheets/layout-side-left-<timestamp>.css
  def css_file_path
    @css_file_path ||= File.join("compiled", "#{css_file_name.css}")
  end

  # The file name of the compiled css file
  # i.e. layout-side-left-<timestamp>
  def css_file_name
    @css_file_name ||= [sass_file_name, Time.now.to_s(:number)].join('-')
  end

  # Sprockets::Environment
  def sprockets_environment
      if Rails.application.assets.is_a?(Sprockets::Index)
        # In production Sprockets::Index caches everything
        # we want the uncached Sprockets::Environment
        Rails.application.assets.instance_variable_get('@environment')
      else 
        Rails.application.assets
      end
  end

  # Sprockets::StaticCompiler
  def sprockets_static_compiler
    @sprockets_static_compiler ||= Sprockets::StaticCompiler.new(
      sprockets_environment,
      File.join(Rails.public_path, Rails.application.config.assets.prefix),
      [css_file_path],
      digest:   true,
      manifest: false
    )
  end

  # Compile css
  def compile
    sprockets_static_compiler.compile
    register_digest
    compiled?
  end

  # Check if the digested file is registered as an asset
  def compiled?
    Rails.application.config.assets.paths.include? css_file_path
  end

  # Register digested file as an asset
  def register_digest
    Rails.application.config.assets.paths << css_file_path
  end
end
