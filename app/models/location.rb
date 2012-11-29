class Location < ActiveRecord::Base

  attr_accessible :uid, :name, :corporate
  has_many :pages, conditions: ["pages.template = ?", false]
  has_one :site_template
  after_create :create_homepage
  before_create :create_template

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

  def github_repo
    "git@github.com:g5search/g5-client-location"
  end

  def heroku_app_name
    "g5-cl-#{name.parameterize[0..23]}"
  end

  def heroku_repo
    "git@heroku.com:#{heroku_app_name}.git"
  end

  def heroku_url
    "https://#{heroku_app_name}.herokuapp.com"
  end
  
  private
  
  def create_template
    create_site_template(name: "Site Template")
  end
  
  def create_homepage
    pages.create(name: "Home")
  end
end
