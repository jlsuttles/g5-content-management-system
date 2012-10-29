class LocationTable < TableCloth::Base
  column :name, :corporate
  action {|location, h| h.link_to location.heroku_url, location.heroku_url }
  action {|location, h| h.link_to "Deploy", h.deploy_location_path(location), method: :post }
  action {|location, h| h.link_to "Show", h.location_path(location) }
  action {|location, h| h.link_to "Edit", h.edit_location_path(location) }
  action {|location, h| h.link_to "Destroy", location, data: { confirm: "Are you sure?" }, method: :delete }
end
