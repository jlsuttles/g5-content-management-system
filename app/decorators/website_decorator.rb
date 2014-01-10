class WebsiteDecorator < Draper::Decorator
  delegate_all
  decorates_association :web_home_template
  decorates_association :web_page_template

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
    "http://#{heroku_app_name}.herokuapp.com"
  end
end
