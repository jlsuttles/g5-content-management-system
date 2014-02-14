Fabricator :garden_widget do
  url { Faker::Internet.url }
  name { Faker::Name.name }
  slug { Faker::Name.name.parameterize }
  thumbnail { Faker::Internet.url }
  edit_html { "<div>edit</div>" }
  show_html { "<div>show</div>" }
end
