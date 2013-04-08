Fabricator :web_template do
  name { Faker::Name.name }
  title { Faker::Name.name }
  slug  { Faker::Name.name.parameterize }
end

Fabricator(:web_template_with_website, from: :web_template) do
  website
end

Fabricator(:web_template_with_web_layout, from: :web_template) do
  web_layout
end

Fabricator(:web_template_with_web_theme, from: :web_template) do
  web_theme
end

Fabricator(:web_template_with_everything, from: :web_template) do
  website
  web_layout
  web_theme
end
