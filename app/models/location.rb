class Location < ActiveRecord::Base
  attr_accessible :uid, :name, :corporate, :urn

  has_one :site_template, conditions: ["pages.template = ?", true]
  has_many :pages, conditions: ["pages.template = ?", false]

  before_create :create_template
  after_create :create_homepage
  after_create :set_urn

  def async_deploy
    Resque.enqueue(LocationDeployer, self.urn)
  end
   
  def deploy
    GithubHerokuDeployer.deploy(
      github_repo: github_repo,
      heroku_app_name: heroku_app_name,
      heroku_repo: heroku_repo
    ) do |repo|
      `cp #{self.compiled_site_path}* #{repo.dir}`
      repo.add('.')
      repo.commit_all "Add compiled site"
    end
  end
  
  def homepage
    pages.home.first
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
    "git@github.com:G5/static-heroku-app.git"
  end

  def heroku_app_name
    urn[0..29] if urn
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
  
  def record_type
    "g5-cl"
  end

  def hashed_id
    "#{self.created_at.to_i}#{self.id}".to_i.to_s(36)
  end
  
  def to_param
    self.urn
  end
  
  def create_root_directory
    delete_compiled_folder
    Dir::mkdir(Location.compiled_site_root) unless Dir::exists?(Location.compiled_site_root)
    Dir::mkdir(compiled_site_path)
  end
  
  def delete_compiled_folder
    FileUtils.rm_rf(compiled_site_path) if Dir::exists?(compiled_site_path)
  end
  
  def delete_repo
    FileUtils.rm_rf("#{Rails.root}/tmp/repos") if Dir::exists?("#{Rails.root}/tmp/repos")
  end
  
  def clean_up
    delete_compiled_folder
    delete_repo
  end
  
  private
  
  def set_urn
    update_attributes(urn: "#{record_type}-#{hashed_id}-#{name.parameterize}")
  end
  
  def create_template
    create_site_template(name: "Site Template")
  end

  def create_homepage
    pages.create(name: "Home")
  end
end
