class AreaPageRenderer
  def initialize(locations, area)
    @locations = locations
    @area = area
  end

  def render
    "<div class='area_page'>#{title + locations + map}</div>"
  end

private

  def title
    "<h1>Locations in #{@area}</h1>"
  end

  def locations
    @locations.inject("") do |html, location|
      html += location_markup(location)
    end
  end

  def map
    ActionController::Base.new.render_to_string(
      partial: "area_pages/map",
      locals: { addresses: location_addresses  }
    )
  end

  def location_markup(location)
    ActionController::Base.new.render_to_string(
      partial: "area_pages/location",
      locals: { location: location }
    )
  end

  def location_addresses
    @locations.map { |location| address_for(location) }
  end

  def address_for(location)
    "#{location.street_address}, #{location.city}, " \
    "#{location.state} #{location.postal_code}"
  end
end
