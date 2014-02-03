class ClientSerializer < ActiveModel::Serializer
  embed :ids, include: true

  has_many :locations

  attributes  :id,
              :urn,
              :name,
              :app_name,
              :url,
              :location_urns,
              :location_urls,
              :cms_urn,
              :cms_app_name,
              :cms_url,
              :cpns_urn,
              :cpns_app_name,
              :cpns_url,
              :cpas_urn,
              :cpas_app_name,
              :cpas_url,
              :cls_urn,
              :cls_app_name,
              :cls_url,
              :cxm_urn,
              :cxm_app_name,
              :cxm_url

  def client_services
    ClientServices.new
  end

  def app_name
    client_services.client_app_name
  end

  def url
    client_services.client_url
  end

  def location_urns
    client_services.client_location_urns
  end

  def location_urls
    client_services.client_location_urls
  end

  ClientServices::SERVICES.each do |service|
    define_method("#{service}_urn") do
      client_services.send(:"#{service}_urn")
    end

    define_method("#{service}_app_name") do
      client_services.send(:"#{service}_app_name")
    end

    define_method("#{service}_url") do
      client_services.send(:"#{service}_url")
    end
  end
end
