Fabricator :garden_web_theme do
  url { Faker::Internet.url }
  name { Faker::Name.name }
  thumbnail { Faker::Internet.url }
end
