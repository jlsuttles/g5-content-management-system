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
