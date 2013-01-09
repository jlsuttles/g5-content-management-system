Fabricator :location do
  name { Faker::Name.name } 
  uid { Faker::Internet.domain_name }
  corporate { false }
  pages(count: 3)
  primary_color "#111111"
  secondary_color "#222222"
end

Fabricator :site_template do
  name { Faker::Name.name } 
  slug  "slug" 
  title "What a wonderful world"
  template true
  page_layout
  theme
end

Fabricator :page do
  name { Faker::Name.name } 
  slug  "slug" 
  title "What a wonderful world"
end

Fabricator :page_layout do
  name { Faker::Name.name } 
  url  "spec/support/single_column_layout.html"
  html "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
end

Fabricator :theme do
  name { Faker::Name.name } 
  url "spec/support/big_picture_theme.html"
end
