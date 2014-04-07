class HerokuClient
  BASE_ENDPOINT = "https://api.heroku.com/apps"

  def initialize(app, api_key)
    @app     = app
    @api_key = api_key
  end

  def releases
    JSON.parse(HTTParty.get(release_resource, headers).body)
  end

  def rollback(slug_id)
    HTTParty.post(release_resource, post_params(slug_id))
  end

protected

  def release_resource
    "#{BASE_ENDPOINT}/#{@app}/releases"
  end

  def encoded_auth
    Base64.encode64(":#{@api_key}")
  end

  def headers
    {
      headers: {
        "Content-Type"  => "application/json",
        "Accept"        => "application/vnd.heroku+json; version=3",
        "Authorization" => encoded_auth
      }
    }
  end

  def post_params(slug_id)
    { body: { release: slug_id } }.merge(headers)
  end
end
