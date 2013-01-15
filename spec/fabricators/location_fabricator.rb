Fabricator :location do
  name { Faker::Name.name } 
  uid { Faker::Internet.domain_name }
  corporate { false }
  pages(count: 3)
  primary_color "#111111"
  secondary_color "#222222"
end

Fabricator :theme do
  name { Faker::Name.name } 
  url "spec/support/big_picture_theme.html"
end
