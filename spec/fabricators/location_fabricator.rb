Fabricator :location do
  name { Faker::Name.name } 
  uid { Faker::Internet.domain_name }
  corporate { false }
  site_template
  pages(count: 3)
end

Fabricator :site_template do
  name { Faker::Name.name } 
  template true
  layout(fabricator: :page_layout)
end

Fabricator :page do
  name { Faker::Name.name } 
end

Fabricator :page_layout do
  name { Faker::Name.name } 
  url { Faker::Internet.domain_name }
  html "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
end
