Fabricator :web_page_template do
  name { Faker::Name.name }
  title { Faker::Name.name }
  slug  { Faker::Name.name.parameterize }
end
