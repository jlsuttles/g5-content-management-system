Fabricator :client do
  uid { Faker::Internet.url }
  name { Faker::Name.name }
  vertical { Faker::Commerce.department }
end
