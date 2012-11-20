class Location < ActiveRecord::Base
  attr_accessible :uid, :name, :corporate

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
    "g5-cl-#{name[0..23]}"
  end

  def heroku_repo
    "git@heroku.com:#{heroku_app_name}.git"
  end

  def heroku_url
    "https://#{heroku_app_name}.herokuapp.com"
  end
end
