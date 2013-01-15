Fabricator :site_template do
  name { Faker::Name.name } 
  slug  "slug" 
  title "What a wonderful world"
  template true
  page_layout
  theme
  location
  aside_widgets(fabricator: :widget, count: 1)
end

