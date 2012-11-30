class Location < ActiveRecord::Base
  attr_accessible :uid, :name, :corporate

  has_one :site_template, conditions: ["pages.template = ?", true]
  has_many :pages, conditions: ["pages.template = ?", false]

  before_create :create_template
  after_create :create_homepage

  def async_deploy
    Resque.enqueue(LocationDeployer, self.id)
  end
   
  def deploy
    GithubHerokuDeployer.deploy(
      github_repo: github_repo,
      heroku_app_name: heroku_app_name,
      heroku_repo: heroku_repo
    )
  end

  def heroku_url
    "https://#{heroku_app_name}.herokuapp.com"
  end

  def stylesheets
    site_template.stylesheets || []
  end

  def javascripts
    site_template.javascripts || []
  end

  def github_repo
    "git@github.com:g5search/g5-client-location"
  end

  def heroku_app_name
    "g5-cl-#{name.parameterize[0..23]}"
  end

  def heroku_repo
    "git@heroku.com:#{heroku_app_name}.git"
  end

  def self.compiled_site_root
    "#{Rails.root}/tmp/compiled_site/"
  end
  
  def compiled_site_path
    Location.compiled_site_root + "#{id}/"
  end
  
  def create_root_directory
    delete_compiled_folder
    Dir::mkdir(Location.compiled_site_root) unless Dir::exists?(Location.compiled_site_root)
    Dir::mkdir(compiled_site_path)
  end
  
  def delete_compiled_folder
    FileUtils.rm_rf(compiled_site_path) if Dir::exists?(compiled_site_path)
  end
  
  private
  
  def create_template
    create_site_template(name: "Site Template")
  end

  def create_homepage
    pages.create(name: "Home")
  end
end
