Fabricator :client do
  name { Faker::Name.name }
  uid { Faker::Internet.domain_name }
end
