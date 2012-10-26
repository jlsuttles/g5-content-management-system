GithubHerokuDeployer.configure do |config|
  config.github_repo     = nil
  config.heroku_api_key  = ENV["HEROKU_API_KEY"]
  config.heroku_app_name = nil
  config.heroku_repo     = nil
  config.heroku_username = ENV["HEROKU_USERNAME"]
  config.ssh_enabled     = true
end
