Fabricator :client do
  uid { Faker::Internet.domain_name }
  name { Faker::Name.name }
end
