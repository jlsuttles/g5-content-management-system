class ReleasesManager
  DEFAULT_LIMIT = 5

  def initialize(website_slug, limit=nil)
    @website_slug = website_slug
    @limit        = limit || DEFAULT_LIMIT
  end

  def fetch_all
    return unless location.present?

    items = JSON.parse(HerokuClient.new(location.website.urn).releases)
    process(filtered(items)).first(@limit)
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

  def filtered(items)
    items.select { |item| item if deploy?(item) || rollback?(item) }
  end

  def current_deploy(items)
    items.reverse!
    return items.first if deploy?(items.first)
    current = items.detect { |item| item["version"] == version(items.first) }

    return current if current.present?

    items.detect { |item| deploy?(item) }
  end

  def process(items)
    flag_current(items).select { |item| item if deploy?(item) }
  end

  def flag_current(items)
    current = current_deploy(items)

    items.each do |item|
      if item == current
        item["current"] = true
      else
        item["current"] = false
      end
    end
  end

  def deploy?(item)
    item["description"] =~ /Deploy/
  end

  def rollback?(item)
    item["description"] =~ /Rollback/
  end

  def version(item)
    item["description"].split("Rollback to v").last.to_i
  end
end
