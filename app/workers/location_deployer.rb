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
      deploy
    ensure
      clean_up
    end
  end

  def compile_pages
    create_root_directory
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
    create_directory(:stylesheets)
    @location.all_stylesheets.each do |stylesheet|
      compile_stylesheet(stylesheet)
    end
  end

  def compile_stylesheet(stylesheet)
    RemoteSassFile.new(stylesheet, stylesheets_path).compile
  end

  def stylesheets_path
    File.join(@location.compiled_site_path, "stylesheets")
  end

  def create_directory(name)
    FileUtils.mkdir_p(File.join(@location.compiled_site_path, name.to_s))
  end

  private
  
  def create_root_directory
    remove_root_directory
    FileUtils.mkdir_p(@location.compiled_site_path)
  end
  
  def deploy
    GithubHerokuDeployer.deploy(
      github_repo: @location.github_repo,
      heroku_app_name: @location.heroku_app_name,
      heroku_repo: @location.heroku_repo
    ) do |repo|
      `cp #{@location.compiled_site_path}* #{repo.dir}`
      repo.add('.')
      repo.commit_all "Add compiled site"
    end
  end
  
  def clean_up
    remove_root_directory
    delete_repo
  end

  def remove_root_directory
    if Dir::exists?(@location.compiled_site_path)
      FileUtils.rm_rf(@location.compiled_site_path)
    end
  end
  
  # TODO: this is not safe, there could be other repos there doing stuff
  def delete_repo
    FileUtils.rm_rf("#{Rails.root}/tmp/repos") if Dir::exists?("#{Rails.root}/tmp/repos")
  end
end
