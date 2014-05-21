Fabricator :website do
  urn { Faker::Name.name }
  owner(fabricator: :location)
end
