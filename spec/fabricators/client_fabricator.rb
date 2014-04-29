Fabricator :client do
  uid { Faker::Internet.url }
  name { Faker::Name.name }
  vertical { "Apartments" }
  type { "MultiDomain" }
end
