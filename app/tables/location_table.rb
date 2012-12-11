class LocationTable < TableCloth::Base
  column :name, :heroku_url
  actions do
    action {|location| link_to "View", location.heroku_url, class: "btn" }
    action {|location| link_to "Pages", location_path(location.id), class: "btn" }
    action {|location| link_to "Deploy", deploy_location_path(location.id), method: :post, class: "btn"}
  end
end
