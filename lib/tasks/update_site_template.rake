task "update_site_templates" => :environment do
  puts "Updating Site Templates..."
  Page.where(template: true).update_all(type: "SiteTemplate")
  puts "Updating Internal Pages..."
  Page.where(template: false).update_all(type: "Page")
end
