Fabricator :garden_web_layout do
  url { Faker::Internet.url }
  name { Faker::Name.name }
  slug { Faker::Name.name.parameterize }
  thumbnail { Faker::Internet.url }
  html { "<div></div>" }
end
