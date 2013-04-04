Fabricator :website_template do
  name { Faker::Name.name }
  slug  "slug"
  title "What a wonderful world"
  template true
  web_layout
  theme
  website
  aside_widgets(fabricator: :widget, count: 1)
end

