class Location < ActiveRecord::Base
  attr_accessible :name, :corporate

  # TODO: async
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
    "g5-cli-loc-#{name[0..18]}"
  end

  def heroku_repo
    "git@heroku.com:#{heroku_app_name}.git"
  end
end
