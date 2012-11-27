module PagesHelper
  
  def preview(page)
    puts page.layout.html
    html = page.layout.html
    widgets = page.widgets.map(&:html)
    html.gsub("<p>Main Column</p>", widgets.join)
  end
end
