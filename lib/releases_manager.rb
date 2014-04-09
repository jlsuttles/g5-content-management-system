class ReleasesManager
  DEFAULT_LIMIT = 10

  def initialize(website_slug, limit=nil)
    @website_slug = website_slug
    @limit        = limit || DEFAULT_LIMIT
  end

  def fetch_all
    return unless location.present?

    items = JSON.parse(HerokuClient.new(location.website.urn).releases)
    items.map { |item| release(item) }.reverse.first(@limit)
  end

  def rollback(release_id)
    return unless location.present?

    HerokuClient.new(location.website.urn).rollback(release_id)
  end

  private

  def location
    @location ||= Location.all.detect do |location|
      location.name.parameterize == @website_slug
    end
  end

  def release(item)
    {
      id: item["id"],
      version: item["version"],
      created_at: item["created_at"],
      description: item["description"],
      user: item["user"]["email"]
    }
  end
end
