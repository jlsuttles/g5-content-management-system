class WebsiteDecorator < Draper::Decorator
  delegate_all

  def github_repo
    "git@github.com:G5/static-heroku-app.git"
  end

  def heroku_app_name
    model.urn[0..29] if model.urn
  end

  def heroku_repo
    "git@heroku.com:#{heroku_app_name}.git"
  end

  def heroku_url
    "https://#{heroku_app_name}.herokuapp.com"
  end
end
