class LocationTable < TableCloth::Base
  column :name
  actions do
    action {|location| link_to "Edit Pages", location_path(location), class: "btn" }
    action {|location| link_to "View on Heroku", location.website.heroku_url, class: "btn" }
    action {|location| link_to "Deploy to Heroku", deploy_location_path(location), method: :post, class: "btn"}
  end
end
