Fabricator :setting do
  name { Faker::Name.name } 
  categories ["Instance"]
  component(fabricator: :widget)
end
