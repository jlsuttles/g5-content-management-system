Fabricator :garden_web_layout do
  url { Faker::Internet.url }
  name { Faker::Name.name }
  slug { |attrs| attrs[:name].to_s.parameterize }
  thumbnail { Faker::Internet.url }
  html { |attrs| <<-EOS
      <div class="layout #{attrs[:slug]}">
        <div id="drop-target-logo"><!-- place logo widget here --></div>
        <span id="drop-target-phone"><!-- phone widget here --></span>
        <span id="drop-target-btn"><!-- btn widget here --></span>
        <div id="drop-target-nav"><!-- nav widget here --></div>
        <aside role="complementary" id="drop-target-aside"></aside>
        <section role="main" id="drop-target-main"></section>
        <div id="drop-target-footer" class="content">
      </div>
    EOS
  }
end
