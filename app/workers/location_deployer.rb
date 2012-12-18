class LocationDeployer
  extend HerokuResqueAutoscaler if Rails.env.production?
  @queue = :deployer

  def self.perform(location_urn)
    new(location_urn).compile_and_deploy
  end

  def initialize(location_urn)
    @location = Location.find_by_urn(location_urn)
  end

  def compile_and_deploy
    begin
      compile_pages
      compile_stylesheets
      compile_javascripts
      deploy
    ensure
      remove_compiled_site
    end
  end

  def compile_pages
    FileUtils.mkdir_p(@location.compiled_site_path)
    homepage_path = File.join(@location.compiled_site_path, "index.html")
    compile_page(@location.homepage, homepage_path)
    @location.pages.each do |page|
      compile_page(page, page.compiled_file_path)
    end
  end

  def compile_page(page, to_path)
    File.open(to_path, "w") do |file|
      file << LocationsController.new.render_to_string(
        "/pages/preview", 
        layout: "compiled_pages", 
        locals: { page: page, location: @location }
      )
    end
  end

  def compile_stylesheets
    FileUtils.mkdir_p(stylesheets_path)
    @location.stylesheets.map do |stylesheet|
      compile_stylesheet(stylesheet)
    end
  end

  def compile_stylesheet(stylesheet)
    remote_stylesheet = RemoteStylesheet.new(
     stylesheet,
     { primary: @location.primary_color,
       secondary: @location.secondary_color },
     stylesheets_path
    )
    remote_stylesheet.compile
  end

  def stylesheets_path
    File.join(@location.compiled_site_path, "stylesheets")
  end

  def stylesheet_path(stylesheet)
    stylesheet_name = stylesheet.split("/").last.split(".").first
    File.join(stylesheets_path, "#{stylesheet_name}.css")
  end

  def compile_javascripts
    FileUtils.mkdir_p(javascripts_path)
    @location.javascripts.map do |javascript|
      compile_javascript(javascript)
    end
  end

  def compile_javascript(javascript)
    remote_javascript = RemoteJavascript.new(
     javascript,
     javascripts_path
    )
    remote_javascript.compile
  end

  def javascripts_path
    File.join(@location.compiled_site_path, "javascripts")
  end

  def javascript_path(javascript)
    javascript_name = javascript.split("/").last
    File.join(javascripts_path, javascript_name)
  end

  private
  
  def remove_compiled_site
    if Dir.exists?(@location.compiled_site_path)
      FileUtils.rm_rf(@location.compiled_site_path)
    end
  end
  
  def deploy
    begin
      remove_repo
      GithubHerokuDeployer.deploy(
        github_repo: @location.github_repo,
        heroku_app_name: @location.heroku_app_name,
        heroku_repo: @location.heroku_repo
      ) do |repo|
        # save dir so we can delete it later
        @repo_dir = repo.dir.to_s
        
        # copy all pages over
        `cp #{@location.compiled_site_path}/* #{repo.dir}`
       
        # copy all stylesheets over
        `mkdir #{repo.dir}/stylesheets`
        `cp #{stylesheets_path}/* #{repo.dir}/stylesheets/`
        
        # cp all javascripts over
        `mkdir #{repo.dir}/javascripts`
        `cp #{javascripts_path}/* #{repo.dir}/javascripts/`
        `cp #{File.join(Rails.root, "public", "javascripts")}/* #{repo.dir}/javascripts/`

        # commit changes
        repo.add('.')
        repo.commit_all "Add compiled site"
      end
    ensure
      # remove_repo
    end
  end
  
  def remove_repo
    FileUtils.rm_rf(@repo_dir) if @repo_dir && Dir.exists?(@repo_dir)
  end
end
