Fabricator :garden_web_theme do
  url { Faker::Internet.url }
  name { Faker::Name.name }
  slug { Faker::Name.name.parameterize }
  thumbnail { Faker::Internet.url }
end
