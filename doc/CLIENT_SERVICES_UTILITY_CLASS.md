# Client Services Utility Class

## How does it work at a high level?

- `ClientServices` provides helper methods to expose service URNs & URLs
- Exposed to widget settings
- Added to the `ClientSerializer` to expose to the Ember app
- Added attrs for the service URNs & URLs to the `Client` model in the Ember app

## Where is it implemented?

- `app/lib/client_services.rb`
- `app/lib/website_seeder.rb`
- `app/serializers/client_serializer.rb`

```ruby
class ClientSerializer < ActiveModel::Serializer

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

    define_method("#{service}_url") do
      client_services.send(:"#{service}_url")
    end
  end


  private

  def client_services
    @client_services ||= ClientServices.new
  end
end
```
