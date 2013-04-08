ENV["HEROKU_APP_NAME"] ||= "g5-ch-default"
ENV["LEADS_SERVICE_HEROKU_APP_NAME"] ||= ENV["HEROKU_APP_NAME"].gsub(/-ch-/, "-cls-")[0..29]
ENV["LEADS_SERVICE_HEROKU_URL"] ||= "http://#{ENV["LEADS_SERVICE_HEROKU_APP_NAME"]}.herokuapp.com/leads"
ENV['WIDGET_GARDEN_URL'] ||= "http://g5-widget-garden.herokuapp.com"

