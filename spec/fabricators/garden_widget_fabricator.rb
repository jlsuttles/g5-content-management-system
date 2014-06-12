Fabricator :garden_widget do
  url { Faker::Internet.url }
  name { Faker::Name.name }
  slug { |attrs| attrs[:name].to_s.parameterize }
  thumbnail { Faker::Internet.url }
  edit_html { "<div>edit</div>" }
  show_html { |attrs| "<div class=\"widget #{attrs[:slug]}\">show</div>" }
  show_stylesheets {["foo.css", "bar.css"]}
  show_javascript {"show.js"}
  lib_javascripts {["a.js", "b.js"]}
end
