class LocationTable < TableCloth::Base
  column :name, :heroku_url
  action {|location, h| h.link_to "View", location.heroku_url, class: "btn" }
  action {|location, h| h.link_to "Deploy", h.deploy_location_path(location), method: :post, class: "btn"}
end
