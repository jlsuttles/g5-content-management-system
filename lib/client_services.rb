class ClientServices
  HEROKU_APP_NAME_MAX_LENGTH = 30
  SERVICES = %w(cms cpns cpas cls cxm)

  #client management system (client hub)
  #client phone number service
  #client pricing & availability service
  #client leads service
  #client experience management?

  # client_location_urn
  # client_location_url

  def client_urn
    Client.first.urn
  end

  def client_app_name
    client_urn[0...HEROKU_APP_NAME_MAX_LENGTH]
  end

  def client_url
    "http://#{client_app_name}.herokuapp.com/"
  end

  SERVICES.each do |service|
    define_method("#{service}_urn") do
      # Custom or replace the Client's app prefix
      ENV["#{service.upcase}_URN"] || client_urn.gsub(/-c-/, "-#{service}-")
    end

    define_method("#{service}_app_name") do
      # Custom or truncate to Heroku's max app name length
      ENV["#{service.upcase}_APP_NAME"] || send(:"#{service}_urn")[0...HEROKU_APP_NAME_MAX_LENGTH]
    end

    define_method("#{service}_url") do
      # Custom or Heroku URL
      ENV["#{service.upcase}_URL"] || ("http://" + send(:"#{service}_app_name") + ".herokuapp.com/")
    end
  end
end
