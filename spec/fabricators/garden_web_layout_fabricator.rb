Fabricator :garden_web_layout do
  url { Faker::Internet.url }
  name { Faker::Name.name }
  thumbnail { Faker::Internet.url }
  html { "<div></div>" }
end
