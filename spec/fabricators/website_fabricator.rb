Fabricator :website do
  urn { Faker::Name.name }
end

Fabricator :website_with_location, class_name: :website do
  location
end
