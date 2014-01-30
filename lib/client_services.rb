class ClientServices
  HEROKU_APP_NAME_MAX_LENGTH = 30
  SERVICES = %w(cms cpns cpas cls cxm)

  #client management system (client hub)
  #client phone number service
  #client pricing & availability service
  #client leads service
  #client experience management?

  # client_urn
  # client_location_urn
  # client_cms_urn
  # client_leads_urn
  # client_pricing_availability_urn
  # client_phone_numbers_urn
  # client_cxm_urn

  # client_url
  # client_location_url
  # client_cms_url
  # client_leads_url
  # client_pricing_availability_url
  # client_phone_numbers_url
  # client_cxm_url

  def client_urn
    Client.first.urn
  end

  # TODO: Programatically generate these methods using SERVICES
  #
  # SERVICES.each do |service|
  #   define_method("#{service}_urn") do
  #     ...
  #   end
  #   ...
  # end

  def cpns_urn
    # Custom or replace the Client's app prefix
    ENV["CPNS_URN"] || client_urn.gsub(/-c-/, "-cpns-")
  end

  def cpns_app_name
    # Custom or truncate to Heroku's max app name length
    ENV["CPNS_APP_NAME"] || cpns_urn[0...HEROKU_APP_NAME_MAX_LENGTH]
  end

  def cpns_url
    # Custom or Heroku URL
    ENV["CPNS_URN"] || "http://#{cpns_app_name}.herokuapp.com/"
  end
end
