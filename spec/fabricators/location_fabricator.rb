Fabricator :location do
  uid { Faker::Internet.domain_name }
  urn { Faker::Name.name }
  name { Faker::Name.name }
end

Fabricator :location_with_website, from: :location  do
  website
end

Fabricator :location_with_website_with_everything, from: :location do
  website { Fabricate(:website_with_everything) }
end
