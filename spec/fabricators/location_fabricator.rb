Fabricator :location do
  name { Faker::Name.name } 
  uid { Faker::Internet.domain_name }
  corporate { false }
end
