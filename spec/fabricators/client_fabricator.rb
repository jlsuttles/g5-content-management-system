Fabricator :client do
  uid { Faker::Internet.url }
  name { Faker::Name.name }
  vertical { "Apartments" }
  domain { Faker::Internet.url }
  type { "MultiDomainClient" }
end
