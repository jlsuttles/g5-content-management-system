Fabricator(:simple_widget, from: :widget) do
  name { Faker::Name.name }
  section 'aside'
  url "spec/support/simple_widget.html"
end

