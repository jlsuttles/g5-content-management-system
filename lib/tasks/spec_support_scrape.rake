require "open-uri"

namespace :spec do
  namespace :support do
    namespace :scrape do

      task widgets: :environment do
        save_web_page(Widget.garden_url, "spec/support/widgets.html")
      end

      task themes: :environment do
        save_web_page(WebTheme.garden_url, "spec/support/themes.html")
      end

      task layouts: :environment do
        save_web_page(WebLayout.garden_url, "spec/support/layouts.html")
      end

    end
  end
end

def save_web_page(source, destination)
  open(destination, "wb") do |file|
    open(source) do |uri|
       file.write(uri.read)
    end
  end
end
